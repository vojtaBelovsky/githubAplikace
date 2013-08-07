//
//  BCIssueInDetailView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCIssueNumberView;
@class BCLabelView;
@class BCIssue;
@class BCIssueTitleLabel;
@class BCIssueBodyLabel;

@interface BCIssueInDetailView : UIView
//rectangle around whole issue
@property UIImageView *profileIssueBackgroundImgView;
@property BCIssueNumberView* issueNumberView;
@property BCIssueBodyLabel *issueBodyLabel;
@property BCIssueTitleLabel *issueTitleLabel;
@property NSMutableArray* labelViewsArray;

- (id)initWithIssue:(BCIssue*)issue;

@end
