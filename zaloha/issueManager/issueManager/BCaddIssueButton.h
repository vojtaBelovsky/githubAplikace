//
//  BCaddIssueButton.h
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCMilestone;
@class BCAddIssueContentImgView;
@class BCUser;

@interface BCaddIssueButton : UIView

@property UILabel *myTitleLabel;
@property UIButton *theNewIssuePlus;
@property UIImageView *separatorImgView;
@property BCAddIssueContentImgView *contentImgView;

-(void) setContentWithText:(NSString*)text;
- (id)initWithTitle:(NSString *)title;

@end
