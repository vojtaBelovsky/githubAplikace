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
@class BCaddIssueButton;
@class BCAddIssueTextField;
@class BCaddIssueButtonMC;
@class SZTextView;

@interface BCAddIssueView : UIScrollView

@property UIImageView *backgroundImageView;
@property UIView *navigationBarView;
@property UIButton *cancelButton;
@property UIButton *createButton;
@property UILabel *theNewIssueLabel;
@property UIImageView *issueForm;
@property BCAddIssueTextField *issueTitle;
@property BCaddIssueButton *addMilestone;
@property BCaddIssueButton *selectAssignee;
@property BCaddIssueButtonMC *selectLabels;
@property SZTextView *issueBody;

-(id) initWithController:(BCAddIssueViewController *)controller;
-(void) rewriteContentWithAssignee:(BCUser *)assignee milestone:(BCMilestone *)milestone andLabels:(NSMutableArray *)labels;

@end
