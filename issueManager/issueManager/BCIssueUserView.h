//
//  BCIssueUserView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/8/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCAvatarImgView;

@interface BCIssueUserView : UIView

@property BCAvatarImgView *avatarImgView;
@property UILabel *userName;
@property UILabel *updated;

-(void)setWithIssue:(BCIssue *)issue;

@end
