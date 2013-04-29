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

@interface BCIssueDetailViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>{
@private
    BCIssueDetailView *_issueDetailview;
}

@property BCIssue *issue;
@property (copy) BCIssue *editedIssue;
//@property BOOL isEditing;
@property NSArray *buttons;
@property UIBarButtonItem *cancelButton;
@property UIBarButtonItem *editButton;

- (id)initWithIssue:(BCIssue *)issue;
-(void) selectAssignee;

@end
