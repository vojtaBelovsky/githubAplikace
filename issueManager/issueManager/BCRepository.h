//
//  BCRepository.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#define NO_REPOSITORIES @"No repositories"

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
@class BCUser;
@class BCOrg;

@interface BCRepository : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *repositoryId;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *issuesUrl;
@property (nonatomic, copy, readonly)
BCUser *owner;
@property int openIssues;

+ (void)getAllRepositoriesOfUserWithSuccess:(void (^)(NSMutableArray *repositories))success failure:(void(^) (NSError *error))failure;

+ (void)getAllRepositoriesFromOrg:(BCOrg *)org WithSuccess:(void (^)(NSMutableArray *allRepositories))success failure:(void(^) (NSError *error)) failure;

- (id)initNoRepositories;

@end
