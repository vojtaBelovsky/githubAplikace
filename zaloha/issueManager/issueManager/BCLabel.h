//
//  BCLabels.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/24/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
@class BCRepository;

@interface BCLabel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) UIColor *color;

+(void)getAllLabelsOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSArray *labels))success failure:(void(^) (NSError * error))failure;

@end
