//
//  BCOrg.m
//  issueManager
//
//  Created by Vojtech Belovsky on 6/4/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCOrg.h"
#import "BCUser.h"
#import "BCHTTPClient.h"

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

+ (void)getAllOrgsFromUser:(BCUser *)user WithSuccess:(void (^)(NSArray *allOrgs))success failure:(void(^) (NSError *error)) failure{
    [[BCHTTPClient sharedInstance] getPath:@"user/orgs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSArray *response = [NSArray arrayWithArray:responseObject];
        NSMutableArray *orgs = [NSMutableArray arrayWithCapacity:[response count]];
        for (NSDictionary *object in response) {
            [orgs addObject:[MTLJSONAdapter modelOfClass:[BCOrg class] fromJSONDictionary:object error:nil]];
        }
        success ( orgs );
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"fail");
    }];
}

@end
