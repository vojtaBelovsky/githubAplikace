//
//  BCRepository.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepository.h"
#import "BCHTTPClient.h"
#import "BCUser.h"

@implementation BCRepository

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"repositoryId": @"id",
             @"name": @"name",
             @"issuesUrl": @"issues_url"
             };
}

+ (NSValueTransformer *)ownerJSONTransformer{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:BCUser.class];
}

+ (NSValueTransformer *)issuesUrlJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSString *newStr = [[NSString alloc] initWithString:[str substringToIndex:[str length]-[@"{/number}" length]]];
        return [newStr substringFromIndex:[@"https://api.github.com/" length]];
    } reverseBlock:^(NSString *str) {
        return [[NSString alloc] initWithFormat:@"%@%@%@",@"https://api.github.com/", str, @"{/number}"];
    }];
}

+(void)getAllCollaboratorsOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSArray *allCollaborators))success failure:(void(^) (NSError * error))failure{
    NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/collaborators",repository.owner.userLogin,repository.name];
    [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *collaboratorsInDictionaries = [[NSMutableArray alloc] initWithArray:responseObject];
        NSMutableArray *collaborators = [[NSMutableArray alloc] init];
        for(NSDictionary *object in collaboratorsInDictionaries){
            [collaborators addObject:[MTLJSONAdapter modelOfClass:[BCUser class] fromJSONDictionary:object error:nil]];
        }
        success ( collaborators );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
    }];
}

+ (void)getAllRepositoriesWithSuccess:(void (^)(NSArray *allRepositories))success failure:(void(^) (NSError *error)) failure{
    [[BCHTTPClient sharedInstance] getPath:@"user/repos" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSArray *response = [NSArray arrayWithArray:responseObject];
        NSMutableArray *repositories = [NSMutableArray arrayWithCapacity:[response count]];
        for (NSDictionary *object in response) {
            [repositories addObject:[MTLJSONAdapter modelOfClass:[BCRepository class] fromJSONDictionary:object error:nil]];
        }
        success ( repositories );
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"fail");
    }];
}

@end