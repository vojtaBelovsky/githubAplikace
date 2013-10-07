//
//  BCUser.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
@class BCUser;

@interface BCUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *userLogin;
@property (nonatomic, copy, readonly) NSNumber *userId;
@property (nonatomic, copy, readonly) NSURL *avatarUrl;
@property (nonatomic, copy, readonly) NSURL *htmlUrl;

+ (BCUser *)sharedInstanceWithSuccess:(void (^)(BCUser *loggedInUser))success failure:(void(^)(NSError *error))failure;

@end
