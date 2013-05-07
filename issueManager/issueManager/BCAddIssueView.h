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
@class BCMilestone;

@interface BCAddIssueView : UIScrollView

@property UIImageView *avatar;
@property UIButton *assignee;
@property UIButton *milestone;
@property UITextView *labels;
@property UITextField *title;
@property UITextView *body;
@property UIButton *labelsButton;

-(id) initWithController:(BCAddIssueViewController *)controller;
-(void) rewriteContentWithAssignee:(BCUser *)assignee milestone:(BCMilestone *)milestone andLabels:(NSArray *)labels;

@end
