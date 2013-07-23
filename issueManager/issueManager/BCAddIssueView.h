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

@interface BCAddIssueView : UIScrollView

@property UIImageView *backgroundImageView;
@property UIView *navigationBarView;
@property UIButton *cancelButton;
@property UIButton *postButton;
@property UILabel *theNewIssueLabel;
@property UILabel *theNewIssueShadowLabel;
@property UIImageView *issueForm;
@property BCAddIssueTextField *issueTitle;
@property BCaddIssueButton *addMilestone;
@property BCaddIssueButton *selectLabels;

@property BCaddIssueButton *selectAssignee;

-(id) initWithController:(BCAddIssueViewController *)controller;
-(void) rewriteContentWithAssignee:(BCUser *)assignee milestone:(BCMilestone *)milestone andLabels:(NSArray *)labels;

@end
