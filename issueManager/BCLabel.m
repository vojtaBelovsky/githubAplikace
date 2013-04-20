//
//  BCLabels.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/24/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLabel.h"

@implementation BCLabel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"name",
             @"color": @"color"
             };
}

@end
