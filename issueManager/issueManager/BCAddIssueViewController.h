//
//  BCAddIssueViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCRepository;
@class BCUser;
@class BCAddIssueView;
@class BCMilestone;
@class BCIssueViewController;

@interface
  BCAddIssueViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>{
@private
  BCRepository *_repository;
  BCAddIssueView *_addIssueView;
}

@property NSArray *labels;
@property NSArray *milestones;
@property NSArray *collaborators;
@property BCMilestone *checkedMilestone;
@property BCUser *checkedAssignee;
@property NSArray *checkedLabels;
@property BCIssueViewController *myParentViewController;

- (id)initWithRepository:(BCRepository *)repository andController:(BCIssueViewController *)controller;

@end
