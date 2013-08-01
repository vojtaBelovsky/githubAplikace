//
//  BCAddIssueButtonMC.h
//  issueManager
//
//  Created by Vojtech Belovsky on 7/25/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCMilestone;
@class BCAddIssueContentImgView;
@class BCUser;

@interface BCaddIssueButtonMC : UIView

@property int originalHeight;
@property int actualHeight;
@property UILabel *myTitleLabel;
@property UIButton *theNewIssuePlus;
@property UIImageView *separatorImgView;
@property UIView *contentView;
@property NSMutableArray *contentImgViews;
@property CGPoint contentOrigin;

-(void) setContentWithLabels:(NSArray*)labels;

- (id)initWithSize:(CGSize)size andTitle:(NSString *)title;

@end
