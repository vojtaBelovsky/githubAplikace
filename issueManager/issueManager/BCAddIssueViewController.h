//
//  BCAddIssueViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCSelectDataManager.h"
@class BCRepository;
@class BCUser;
@class BCAddIssueView;
@class BCMilestone;
@class BCIssueViewController;

@interface BCAddIssueViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, BCSelectDataManager>{
@private
    BCRepository *_repository;
    
    BCAddIssueView *_addIssueView;
    BCMilestone *_milestone;
    NSArray *_labels;
}

@property BCIssueViewController *myParentViewController;
@property BCUser *assignee;
@property BOOL isSetedAssignee;
@property BOOL isSetedMilestone;
@property BOOL isSetedLabel;

- (id)initWithRepository:(BCRepository *)repository andController:(BCIssueViewController *)controller;

@end
