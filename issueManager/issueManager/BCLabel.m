//
//  BCLabels.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/24/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLabel.h"
#import "BCRepository.h"
#import "BCUser.h"
#import "BCHTTPClient.h"

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

+(void)getAllLabelsOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSArray *allLables))success failure:(void(^) (NSError * error))failure{
  NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/labels",repository.owner.userLogin,repository.name];
  [[BCHTTPClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    NSMutableArray *labelsInDictionaries = [[NSMutableArray alloc] initWithArray:responseObject];
    NSMutableArray *labels = [[NSMutableArray alloc] init];
    for(NSDictionary *object in labelsInDictionaries){
      [labels addObject:[MTLJSONAdapter modelOfClass:[BCLabel class] fromJSONDictionary:object error:nil]];
    }
    success ( labels );
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"fail");
  }];
}

@end
