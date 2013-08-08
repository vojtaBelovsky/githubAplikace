//
//  BCMilestone.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCMilestone.h"

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
@end
