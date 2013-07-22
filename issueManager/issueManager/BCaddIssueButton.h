//
//  BCaddIssueButton.h
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCMilestone;

@interface BCaddIssueButton : UIButton

@property UILabel *myTitleLabel;
@property UIButton *theNewIssuePlus;
@property CGRect rectOfNewIssuePlus;
@property UIImageView *separatorImgView;
@property UILabel *milestoneLabel;
@property CGRect rectOfMilestoneLabelWithPlus;
@property CGRect rectOfMilestoneLabelWithoutPlus;
@property (getter = havePlus) BOOL showPlus;

- (id)initWithSize:(CGSize)size andTitle:(NSString *)title;
-(void) setMilestoneLabelWithMilestone:(BCMilestone *)milestone;
@end
