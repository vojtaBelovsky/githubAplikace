//
//  BCRepository.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepository.h"
#import "BCHTTPClient.h"

@implementation BCRepository

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"repositoryId": @"id",
             @"name": @"name",
             @"issuesUrl": @"issues_url"
             };
}

+ (NSValueTransformer *)issuesUrlJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [str substringToIndex:[str length]-[@"{/number}" length]];
    } reverseBlock:^(NSString *str) {
        return [[NSString alloc] initWithFormat:@"%@%@", str, @"{/number}"];
    }];
}

+ (void)getAllRepositoriesWithSuccess:(void (^)(NSArray *repositories))success failure:(void(^) (NSError *error)) failure{
    [[BCHTTPClient sharedInstance] getPath:@"user/repos" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSArray *response = [NSArray arrayWithArray:responseObject];
        
        NSMutableArray *repositories = [NSMutableArray arrayWithCapacity:[response count]];
        
        for (NSDictionary *object in response) {
            [repositories addObject:[MTLJSONAdapter modelOfClass:[BCRepository class] fromJSONDictionary:object error:nil]];
        }
    }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                       NSLog(@"fail");
                                   }];
}

@end