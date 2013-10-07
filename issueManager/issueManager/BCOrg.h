//
//  BCOrg.h
//  issueManager
//
//  Created by Vojtech Belovsky on 6/4/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Mantle/Mantle.h>
@class BCUser;

@interface BCOrg : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *orgLogin;
@property (nonatomic, copy, readonly) NSNumber *orgId;
@property (nonatomic, copy, readonly) NSURL *avatarUrl;

+ (void)getAllOrgsWithSuccess:(void (^)(NSArray *allOrgs))success failure:(void(^) (NSError *error)) failure;

@end
