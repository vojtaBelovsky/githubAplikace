//
//  BCRepository.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
@class BCUser;

@interface BCRepository : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *repositoryId;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *issuesUrl;
@property (nonatomic, copy, readonly)
BCUser *owner;

+ (void)getAllRepositoriesWithSuccess:(void (^)(NSArray *repositories))success failure:(void(^) (NSError *error)) failure;

@end
