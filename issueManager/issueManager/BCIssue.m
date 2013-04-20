//
//  GHIssue.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/21/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssue.h"

@implementation BCIssue

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

+ (NSValueTransformer *)labeslJSONTransformer {
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

@end