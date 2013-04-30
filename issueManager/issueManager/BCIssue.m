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


@implementation BCIssue

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
             @"repository": @"repository"
             };
}

+ (NSValueTransformer *)labesJSONTransformer {
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
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BCMilestone class]];
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

+(void)getAllIssuesFromRepository:(BCRepository *)repository WithSuccess:(void(^)(NSArray* issues))success failure:(void(^)(NSError * error))failrue{
    [[BCHTTPClient sharedInstance] getPath:repository.issuesUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *responseIssues = [[NSArray alloc] initWithArray:responseObject];
        NSMutableArray *issues = [[NSMutableArray alloc] initWithCapacity:[responseIssues count]];
        int i = 0;
        for(NSDictionary *object in responseIssues){
            [issues addObject:[MTLJSONAdapter modelOfClass:[BCIssue class] fromJSONDictionary:object error:nil]];
            [[issues objectAtIndex:i] setRepository:repository];
            i++;
        }
        success( issues );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
}

@end