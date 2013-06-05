//
//  BCOrg.m
//  issueManager
//
//  Created by Vojtech Belovsky on 6/4/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCOrg.h"

@implementation BCOrg

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"orgLogin": @"login",
             @"orgId": @"id",
             @"avatarUrl" : @"avatar_url",
             @"htmlUrl": @"html_url"
             };
}

+ (NSValueTransformer *)avatarUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)htmlUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
