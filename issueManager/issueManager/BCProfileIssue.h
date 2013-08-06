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

@interface BCProfileIssue : UIView

//rectangle around whole issue
@property UIImageView *profileIssueBackgroundImgView;
@property BCIssueNumberView* issueNumberView;
@property BCIssueTitleLabel *issueTitleLabel;
@property NSMutableArray* labelViewsArray;
@property BCIssue *issue;

- (void)setWithIssue:(BCIssue*)issue;

@end
