//
//  GHIssue.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/21/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "BCUser.h"
#import "BCMilestone.h"
#import "BCRepository.h"
#import "BCLabel.h"

typedef enum : NSUInteger {
    GHIssueStateOpen,
    GHIssueStateClosed
} GHIssueState;

@interface BCIssue : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSURL *htmlUrl;
@property (nonatomic, copy, readonly) NSNumber *idOfIssue;
@property (nonatomic, copy, readonly) NSNumber *number;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, assign, readonly) GHIssueState state;
@property (nonatomic, copy, readonly) NSDate *updatedAt;
@property (nonatomic, copy, readonly) NSArray *labels;
@property (nonatomic, strong, readonly) BCUser *assignee;
@property (nonatomic, strong, readonly) BCUser *user;
@property (nonatomic, strong, readonly) BCMilestone *milestone;
@property (nonatomic, strong, readonly) BCRepository *repository;


@end
