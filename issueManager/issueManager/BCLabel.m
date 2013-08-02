//
//  BCLabels.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/24/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLabel.h"

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation BCLabel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"name",
             @"color": @"color"
             };
}

+ (NSValueTransformer *)colorJSONTransformer{
  return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString* str) {
    unsigned result = 0;
    [[NSScanner scannerWithString:str] scanHexInt:&result];
    UIColor* labelColor = UIColorFromRGB(result);
    return labelColor;
  }];
}

@end
