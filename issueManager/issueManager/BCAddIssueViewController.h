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

@interface BCAddIssueViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, BCSelectDataManager>{
@private
    BCRepository *_repository;
    BCUser *_assignee;
    BCAddIssueView *_issueDetailview;
    BCMilestone *_milestone;
    NSArray *_labels;
}

@property BOOL isSetedAssignee;
@property BOOL isSetedMilestone;
@property BOOL isSetedLabel;

- (id)initWithRepository:(BCRepository *)repository;

@end
