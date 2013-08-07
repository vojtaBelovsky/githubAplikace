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
@class BCIssueNumberView;
@class BCIssueTitleLabel;
@class BCIssueBodyLabel;
@class BCIssueInDetailView;

@interface BCIssueDetailView : UIScrollView

@property BCIssue *issue;
@property UIImageView *backgroundImageView;
@property UIView *navigationBarView;
@property UIButton *backButton;
@property UIButton *closeButton;
@property UILabel *theNewIssueLabel;
@property UILabel *theNewIssueShadowLabel;
@property BCIssueInDetailView *issueView;

-(id) initWithIssue:(BCIssue *)issue andController:(BCIssueDetailViewController *)controller;

-(void) rewriteContentWithIssue:(BCIssue *)issue;

@end
