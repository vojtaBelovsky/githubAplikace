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
-(BOOL)isSetedAssignee;
-(void)setNewMilestone:(BCMilestone *)milestone;
-(BCMilestone *)getMilestone;
-(BOOL)isSetedMilestone;
-(void)setNewLables:(NSArray *)labels;
-(NSArray *)getLabels;
-(BOOL)isSetedLabel;

@end
