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

+(void)getAllCollaboratorsOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSArray *allCollaborators))success failure:(void(^) (NSError * error))failure;

+(void)getAllMilestonesOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSMutableArray *allMilestones))success failure:(void(^) (NSError * error))failure;

+(void)getAllLabelsOfRepository:(BCRepository *)repository withSuccess:(void(^)(NSArray *allLables))success failure:(void(^) (NSError * error))failure;

//+(void)getAllRepositoriesFromUser:(BCUser *)user WithSuccess:(void (^)(NSArray *allRepositories))success failure:(void(^) (NSError *error)) failure;

- (id)initNoRepositories;

@end
