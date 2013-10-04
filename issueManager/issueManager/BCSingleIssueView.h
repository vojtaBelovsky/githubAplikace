//
//  BCProfileIssue.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/2/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OFFSET_BETWEEN_LABELS        ( 4.0f )
#define TOP_OFFSET_BETWEEN_CONTENT   ( 10.0f )

@class BCIssueNumberView;
@class BCLabelView;
@class BCIssue;
@class BCIssueTitleLabel;
@class BCIssueBodyLabel;
@class BCIssueUserView;

@interface BCSingleIssueView : UIView

@property CGFloat offset;
@property BOOL showAll;
//rectangle around whole issue
@property UIImageView *profileIssueBackgroundImgView;
@property BCIssueNumberView* numberView;
@property BCIssueTitleLabel *titleLabel;
@property BCIssueBodyLabel *bodyLabel;
@property BCIssueUserView *userView;
@property NSMutableArray* labelViewsArray;
@property (nonatomic) BCIssue *issue;

- (id)initWithTitleFont:(UIFont *)font showAll:(BOOL)showAll offset:(CGFloat)offset;
+(CGSize)sizeOfSingleIssueViewWithIssue:(BCIssue *)issue width:(CGFloat)width offset:(CGFloat)offset titleFont:(UIFont *)font showAll:(BOOL)show;

@end
