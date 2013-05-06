//
//  BCIssueDetailViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/26/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCSelectDataManager.h"
@class BCIssue;
@class BCIssueDetailView;
@class BCUser;

@interface BCIssueDetailViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, BCSelectDataManager>{
@private
    BCIssueDetailView *_issueDetailview;
}

@property BCIssue *issue;
@property (copy) BCIssue *editedIssue;
@property NSMutableArray *buttons;
@property UIBarButtonItem *cancelButton;
@property UIBarButtonItem *editButton;
@property BOOL isSetedAssignee;
@property BOOL isSetedMilestone;
@property BOOL isSetedLabel;

- (id)initWithIssue:(BCIssue *)issue;

@end
