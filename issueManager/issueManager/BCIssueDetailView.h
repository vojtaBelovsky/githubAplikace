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

@interface BCIssueDetailView : UIScrollView

@property UIImageView *avatar;
@property UIButton *assignee;
@property UIButton *milestone;
@property UITextView *labels;
@property UITextField *title;
@property UITextView *body;
@property UIButton *labelsButton;

-(id) initWithIssue:(BCIssue *)issue andController:(BCIssueDetailViewController *)controller;

-(void) rewriteContentWithIssue:(BCIssue *)issue;

@end
