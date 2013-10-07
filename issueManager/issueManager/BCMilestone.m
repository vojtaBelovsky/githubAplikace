//
//  BCMilestone.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCMilestone.h"
#import "BCRepository.h"
#import "BCHTTPClient.h"
#import "BCUser.h"

@implementation BCMilestone

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
  return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"title",
             @"milestoneId": @"id",
             @"number" : @"number",
             @"dueOn" : @"due_on"
             };
}

+ (NSValueTransformer *)dueOnJSONTransformer{
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
    return [self.dateFormatter dateFromString:str];
  } reverseBlock:^(NSDate *date) {
    return [self.dateFormatter stringFromDate:date];
  }];

}

+(void)getAllMilestonesOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSMutableArray *allMilestones))success failure:(void(^) (NSError * error))failure{
  NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/milestones",repository.owner.userLogin,repository.name];
  [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    NSMutableArray *milestonesInDictionaries = [[NSMutableArray alloc] initWithArray:responseObject];
    NSMutableArray *milestones = [[NSMutableArray alloc] init];
    for(NSDictionary *object in milestonesInDictionaries){
      [milestones addObject:[MTLJSONAdapter modelOfClass:[BCMilestone class] fromJSONDictionary:object error:nil]];
    }
    success ( milestones );
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    failure(error);
  }];
}

@end
