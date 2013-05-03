//
//  BCManageIssueViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCUser;

@protocol BCManageIssue <NSObject>

-(void) setNewAssignee:(BCUser *)assignee;
-(BCUser*)getAssignee;
-(BOOL)isSetedAssignee;

@end
