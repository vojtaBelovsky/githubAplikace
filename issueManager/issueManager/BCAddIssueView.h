//
//  BCAddIssueView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCAddIssueViewController;
@class BCUser;

@interface BCAddIssueView : UIView

@property UIImageView *avatar;
@property UIButton *assignee;
@property UITextField *title;
@property UITextView *body;

-(id) initWithController:(BCAddIssueViewController *)controller;
-(void) rewriteContentWithAssignee:(BCUser *)assignee;

@end
