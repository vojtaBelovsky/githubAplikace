//
//  GHIssue.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/21/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
@class BCUser;
@class BCMilestone;
@class BCRepository;

typedef enum : NSUInteger {
    GHIssueStateOpen,
    GHIssueStateClosed
} GHIssueState;

@interface BCIssue : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSURL *htmlUrl;
@property (nonatomic, copy) NSNumber *idOfIssue;
@property (nonatomic, copy) NSNumber *number;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, assign) GHIssueState state;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, copy) NSArray *labels;
@property (nonatomic, strong) BCUser *assignee;
@property (nonatomic, strong) BCUser *user;
@property (nonatomic, strong) BCMilestone *milestone;
@property (nonatomic, strong) BCRepository *repository;

+(void)getAllIssuesFromRepository:(BCRepository *)repository WithSuccess:(void(^)(NSMutableArray* issues))success failure:(void(^)(NSError * error))failrue;

-(NSArray *)getLabelsAsStrings;

+(CGFloat)heightOfIssueInProfileWithIssue:(BCIssue*)issue withFont:(UIFont *)font;

+(CGFloat)heightOfIssueInDetailWithIssue:(BCIssue *)issue withFont:(UIFont*)font;

@end
