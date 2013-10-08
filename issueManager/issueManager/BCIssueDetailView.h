//
//  BCIssueDetailView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/26/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#define ISSUE_WIDTH                   ( 300.0f )
#define BOTTOM_OFFSET                        ( 44.f )

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
@property UILabel *userNameLabel;
@property UILabel *repositoryNameLabel;
@property BCSingleIssueView *issueView;
@property BCHeadeView *headerView;
@property NSMutableArray *commentViews;
@property UIButton *addNewCommentButton;
@property BCCommentView *myNewCommentView;
@property BOOL addedNewComment;
@property CGFloat sizeOfKeyborad;
@property UIActivityIndicatorView *activityIndicatorView;

-(id) initWithIssue:(BCIssue *)issue andController:(BCIssueDetailViewController *)controller;

-(void)setCommentViewsWithComments:(NSArray*)comments;

@end
