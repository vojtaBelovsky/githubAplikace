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
#import "UIAlertView+errorAlert.h"
#import "BCRepository.h"

@implementation BCOrg

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"orgLogin": @"login",
             @"orgId": @"id",
             @"avatarUrl" : @"avatar_url"
             };
}

+ (NSValueTransformer *)avatarUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)htmlUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (void)getAllOrgsWithSuccess:(void (^)(NSArray *allOrgs))success failure:(void(^) (NSError *error)) failure{
    [[BCHTTPClient sharedInstance] getPath:@"user/orgs" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
      NSArray *response = [NSArray arrayWithArray:responseObject];
      NSMutableArray *orgs = [NSMutableArray arrayWithCapacity:[response count]];
      for (NSDictionary *object in response) {
        [orgs addObject:[MTLJSONAdapter modelOfClass:[BCOrg class] fromJSONDictionary:object error:nil]];
      }
        success ( orgs );
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [UIAlertView showWithError:error];
    }];
}

+ (void)getAllRepositoriesFromOrg:(BCOrg *)org WithSuccess:(void (^)(NSMutableArray *allRepositories))success failure:(void(^) (NSError *error)) failure{
  NSString *path = [[NSString alloc] initWithFormat:@"orgs/%@/repos", org.orgLogin];
  [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
    
    NSArray *response = [NSArray arrayWithArray:responseObject];
    NSMutableArray *repositories = [NSMutableArray arrayWithCapacity:[response count]];
    for (NSDictionary *object in response) {
      [repositories addObject:[MTLJSONAdapter modelOfClass:[BCRepository class] fromJSONDictionary:object error:nil]];
    }
    success ( repositories );
  }failure:^(AFHTTPRequestOperation *operation, NSError *error){
    failure (error);
  }];
}

@end
