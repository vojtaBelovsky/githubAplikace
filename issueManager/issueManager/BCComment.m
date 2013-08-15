//
//  BCComment.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/15/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCComment.h"
#import "BCUser.h"
#import "BCIssue.h"
#import "BCHTTPClient.h"
#import "BCRepository.h"

@implementation BCComment

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
  return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"commentId": @"id",
           @"user": @"user",
           @"updatedAt": @"updated_at"
           };
}



+ (NSValueTransformer *)userJSONTransformer {
  return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BCUser class]];
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
    return [self.dateFormatter dateFromString:str];
  } reverseBlock:^(NSDate *date) {
    return [self.dateFormatter stringFromDate:date];
  }];
}

+(void)getCommentsForIssue:(BCIssue *)issue withSuccess:(void(^)(NSMutableArray *comments))success failure:(void(^)(NSError *error))failure{
  NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues/%@/comments",issue.repository.owner.userLogin, issue.repository.name, issue.number];
  [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSArray *responseComments = [[NSArray alloc] initWithArray:responseObject];
    NSMutableArray *comments = [[NSMutableArray alloc] initWithCapacity:[responseComments count]];
    for(NSDictionary *object in responseComments){
      [comments addObject:[MTLJSONAdapter modelOfClass:[BCComment class] fromJSONDictionary:object error:nil]];
    }
    success( comments );
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    failure( error );
  }];
}


@end
