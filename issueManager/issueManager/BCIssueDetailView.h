//
//  BCIssueDetailView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/26/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCIssue;
@class BCIssueDetailViewController;

@interface BCIssueDetailView : UIView

@property UIImageView *avatar;
@property UIButton *assignee;
@property UITextField *title;
@property UITextView *body;

-(id) initWithIssue:(BCIssue *)issue andController:(BCIssueDetailViewController *)controller;

-(void) rewriteContentWithIssue:(BCIssue *)issue;

@end
