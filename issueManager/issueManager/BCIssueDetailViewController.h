//
//  BCIssueDetailViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/26/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCIssue;
@class BCIssueDetailView;
@class BCUser;
@class BCIssueViewController;

@interface BCIssueDetailViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>{
@private
    BCIssueDetailView *_issueDetailview;
}

@property BCIssueViewController *myParentViewController;
@property BCIssue *issue;
@property (copy) BCIssue *editedIssue;

- (id)initWithIssue:(BCIssue *)issue andController:(BCIssueViewController *)controller;

@end
