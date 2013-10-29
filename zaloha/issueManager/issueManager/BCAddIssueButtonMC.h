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
@property (nonatomic) NSMutableArray *labels;

- (id)initWithTitle:(NSString *)title;
-(CGSize)countMySizeWithWidth:(CGFloat)width;

@end
