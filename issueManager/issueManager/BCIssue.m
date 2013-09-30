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

#define PAGINATION 30

@implementation BCIssue

- (id)initNoIssues
{
  self = [super init];
  if (self) {
    _title = NO_ISSUES;
  }
  return self;
}

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

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"htmlUrl": @"html_url",
             @"idOfIssue": @"id",
             @"updatedAt": @"updated_at",
             @"state" : @"state",
             @"assignee": @"assignee",
             @"user": @"user",
             @"milestone": @"milestone",
             @"repository": @"repository",
             @"labels" : @"labels"
             };
}

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

+ (NSValueTransformer *)htmlUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

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

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+(void)getIssuesFromRepository:(BCRepository *)repository forUser:(BCUser *)user since:(NSDate *)since WithSuccess:(void(^)(NSMutableArray* issues))success failure:(void(^)(NSError * error))failrue{
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"open", @"state", @"updated", @"sort", user.userLogin, @"assignee", nil];
  if (since != nil) {
    NSString *sinceInString = [self.dateFormatter stringFromDate:since];
    [params setObject:sinceInString forKey:@"since"];
  }
  
  [[BCHTTPClient sharedInstance] getPath:repository.issuesUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSArray *responseIssues = [[NSArray alloc] initWithArray:responseObject];
    NSMutableArray *issues = [[NSMutableArray alloc] initWithCapacity:[responseIssues count]];
    int i = 0;
    for(NSDictionary *object in responseIssues){
      [issues addObject:[MTLJSONAdapter modelOfClass:[BCIssue class] fromJSONDictionary:object error:nil]];
      BCIssue *myIssue = [issues objectAtIndex:i];
      [myIssue setRepository:repository];
      i++;
    }
    success( issues );
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [UIAlertView showWithError:error];
  }];
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








