//
//  BCManageIssueViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCUser;
@class BCMilestone;
@class BCLabel;

@protocol BCSelectDataManager <NSObject>

-(void) setNewAssignee:(BCUser *)assignee;
-(BCUser *)getAssignee;
-(void)setNewMilestone:(BCMilestone *)milestone;
-(BCMilestone *)getMilestone;
-(void)setNewLables:(NSArray *)labels;
-(NSArray *)getLabels;

@end
