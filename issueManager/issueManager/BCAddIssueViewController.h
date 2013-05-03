//
//  BCAddIssueViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCManageIssue.h"
@class BCRepository;
@class BCUser;
@class BCAddIssueView;


@interface BCAddIssueViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, BCManageIssue>{
@private
    BCRepository *_repository;
    BCUser *_assignee;
    BCAddIssueView *_issueDetailview;
}

@property BOOL isSetedAssignee;

- (id)initWithRepository:(BCRepository *)repository;
-(void) setNewAssignee:(BCUser *)assignee;
-(BCUser*)getAssignee;

@end
