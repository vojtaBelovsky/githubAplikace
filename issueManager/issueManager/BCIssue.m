//
//  GHIssue.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/21/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssue.h"
#import "BCHTTPClient.h"
#import "BCUser.h"
#import "BCMilestone.h"
#import "BCRepository.h"
#import "BCLabel.h"
#import "UIAlertView+errorAlert.h"
#import "BCComment.h"

@implementation BCIssue

//inicializační metoda pro vytvoření úkolu, který reprezentuje
//prázdný repozitář (repozitář bez úkolu pro vybraného uživatele)
- (id)initNoIssues
{
  self = [super init];
  if (self) {
    _title = NO_ISSUES;
  }
  return self;
}

//Metoda copyWithZone: slouží k vytvoření hluboké kopie,
//specifikujeme v ní jak kopírovat property třídy.
- (id)copyWithZone:(NSZone *)zone{
    BCIssue *newIssue = [[BCIssue alloc] init];
    
    if(newIssue){
        newIssue.htmlUrl = [_htmlUrl copyWithZone:zone];
        newIssue.idOfIssue = [_idOfIssue copyWithZone:zone];
        newIssue.number = [_number copyWithZone:zone];
        newIssue.title = [_title copyWithZone:zone];
        newIssue.body = [_body copyWithZone:zone];
        newIssue.updatedAt = [_updatedAt copyWithZone:zone];
        newIssue.labels = [_labels copyWithZone:zone];
        newIssue.assignee = [_assignee copyWithZone:zone];
        newIssue.user = [_user copyWithZone:zone];
        newIssue.milestone = [_milestone copyWithZone:zone];
        newIssue.repository = [_repository copyWithZone:zone];
        
        if(_state == GHIssueStateClosed){
            newIssue.state = GHIssueStateClosed;
        }else{
            newIssue.state = GHIssueStateOpen;
        }
    }
    return newIssue;
}

//Metodou dateFormatter definujeme způsob, jakým má rogram převést data v JSONu na objekt NSDate.
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

//Tato metoda vrací dictionary, který definuje které
//objekdy JSONu mapovat na které property objektu.
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"htmlUrl": @"html_url",
             @"idOfIssue": @"id",
             @"updatedAt": @"updated_at"
             };
}

//Metoda labelsJSONTransformer definuje způsob transformace objektů label z JSONu na objekty BCLabel.
//V metodě je implementován i blok pro zpětný převed z objektu na JSON. Ten zatím v aplikaci
//nevyužívám, ale stačilo mi k tomu jen pár řádků kódu a objekt je pro převod připraven.
//Kód pro převod objektu na JSON demonstruje jednoduchost s jakou lze tuto akci pomocí
//rámce Mantle implementovat.
+ (NSValueTransformer *)labelsJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *labels) {
        NSMutableArray *labelObjects = [NSMutableArray arrayWithCapacity:[labels count]];
        for(NSDictionary *object in labels){
            [labelObjects addObject:[MTLJSONAdapter modelOfClass:[BCLabel class] fromJSONDictionary:object error:nil]];
        }
        return labelObjects;
    } reverseBlock:^(NSArray *labelObjects) {
        NSMutableArray *labelsInArray = [NSMutableArray arrayWithCapacity:[labelObjects count]];
        for(BCLabel *object in labelObjects){
            [labelsInArray addObject: @{@"name": object.name, @"color": object.color}];
        }
        return labelsInArray;
    }];
}

//Ukázka jednoduché transformační metody (transformace z JSONu na objekt NSURL).
+ (NSValueTransformer *)htmlUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

//Transformační metoda pro převod mnou definovaného datového typu GHIssueState
//na řetězec a zpět.
+ (NSValueTransformer *)stateJSONTransformer {
    NSDictionary *states = @{
                             @"open": @(GHIssueStateOpen),
                             @"closed": @(GHIssueStateClosed)
                             };
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return states[str];
    } reverseBlock:^(NSNumber *state) {
        return [states allKeysForObject:state].lastObject;
    }];
}

//Ukázka jednoduché transformační metody (transformace z JSONu na objekt BCUser).
+ (NSValueTransformer *)assigneeJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:BCUser.class];
}

+ (NSValueTransformer *)userJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:BCUser.class];
}

+ (NSValueTransformer *)milestoneJSONTransformer {    
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:BCMilestone.class];
}

+ (NSValueTransformer *)repositoryJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:BCRepository.class];
}

//Transformační metoda využívající dříve vytvořený dateFormatter.
+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

//Statická metoda pomocí které získáváme všechny úkoly z daného repozitáře pro daného uživatele.
+(void)getIssuesFromRepository:(BCRepository *)repository forUser:(BCUser *)user WithSuccess:(void(^)(NSMutableArray* issues))success failure:(void(^)(NSError * error))failrue{
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"open", @"state", @"updated", @"sort", user.userLogin, @"assignee", nil];
  __block int page = 1;
  
  __block NSMutableArray *issues = [[NSMutableArray alloc] init];
  __block void (^myFailureBlock) (AFHTTPRequestOperation *operation, NSError *error);
  myFailureBlock = [^(AFHTTPRequestOperation *operation, NSError *error) {
    failrue(error);
  } copy];
  
  __block void (^mySuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);
  mySuccessBlock = [^(AFHTTPRequestOperation *operation, id responseObject) {
    NSArray *responseIssues = [[NSArray alloc] initWithArray:responseObject];
    
    for(NSDictionary *object in responseIssues){
      BCIssue *myIssue = [MTLJSONAdapter modelOfClass:[BCIssue class] fromJSONDictionary:object error:nil];
      [myIssue setRepository:repository];
      [issues addObject:myIssue];
    }
    if ([responseIssues count]) {
      page++;
      [params setObject:[[NSString alloc] initWithFormat:@"%d",page] forKey:@"page"];
      [[BCHTTPClient sharedInstance] getPath:repository.issuesUrl parameters:params success:mySuccessBlock failure:myFailureBlock];
    }else{
      success(issues);
      mySuccessBlock = nil;
    }
  } copy];
  
  [[BCHTTPClient sharedInstance] getPath:repository.issuesUrl parameters:params success:mySuccessBlock failure:myFailureBlock];
}

-(NSArray *)getLabelsAsStrings{
    NSMutableArray *labels = [[NSMutableArray alloc] init];
    for(BCLabel *object in _labels){
        [labels addObject:object.name];
    }
    NSArray * unmutableLabels = [[NSArray alloc] initWithArray:labels];
    return unmutableLabels;
}

@end


