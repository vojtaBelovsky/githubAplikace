//
//  BCComment.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/15/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Mantle/Mantle.h>
@class BCUser;
@class BCIssue;

@interface BCComment : MTLModel <MTLJSONSerializing>

@property NSNumber *commentId;
@property NSString *body;
@property BCUser *user;
@property NSDate *updatedAt;

+(void)getCommentsForIssue:(BCIssue *)issue withSuccess:(void(^)(NSMutableArray *comments))success failure:(void(^)(NSError *error))failure;

- (id)initNewComment;

@end
