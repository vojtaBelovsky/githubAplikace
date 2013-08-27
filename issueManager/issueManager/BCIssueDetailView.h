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
@class BCSingleIssueView;
@class BCHeadeView;
@class BCCommentView;

@interface BCIssueDetailView : UIScrollView

@property BCIssue *issue;
@property UIImageView *backgroundImageView;
@property UIView *navigationBarView;
@property UIButton *backButton;
@property UIButton *closeButton;
@property UILabel *theNewIssueLabel;
@property UILabel *theNewIssueShadowLabel;
@property BCSingleIssueView *issueView;
@property BCHeadeView *headerView;
@property NSMutableArray *commentViews;
@property UIButton *addNewCommentButton;
@property BCCommentView *myNewCommentView;
@property BOOL addedNewComment;
@property CGFloat sizeOfKeyborad;

-(id) initWithIssue:(BCIssue *)issue andController:(BCIssueDetailViewController *)controller;

@end
