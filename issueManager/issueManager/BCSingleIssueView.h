//
//  BCProfileIssue.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/2/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCIssueNumberView;
@class BCLabelView;
@class BCIssue;
@class BCIssueTitleLabel;
@class BCIssueBodyLabel;
@class BCIssueUserView;

@interface BCSingleIssueView : UIView

//rectangle around whole issue
@property BOOL showAll;
@property UIImageView *profileIssueBackgroundImgView;
@property BCIssueNumberView* numberView;
@property BCIssueTitleLabel *titleLabel;
@property BCIssueBodyLabel *bodyLabel;
@property BCIssueUserView *userView;
@property NSMutableArray* labelViewsArray;
@property BCIssue *issue;

- (void)setWithIssue:(BCIssue*)issue;

- (id)initWithTitleFont:(UIFont *)font showAll:(BOOL)showAll;

@end
