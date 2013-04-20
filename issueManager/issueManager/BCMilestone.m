//
//  BCMilestone.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCMilestone.h"

@implementation BCMilestone

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"title",
             @"milestoneId": @"id",
             @"number" : @"number"
             };
}

@end
