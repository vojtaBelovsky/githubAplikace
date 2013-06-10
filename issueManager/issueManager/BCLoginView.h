//
//  BCLoginView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCTextField;

@interface BCLoginView : UIView

@property UIImageView *background;
@property UIImageView *octocat;
@property BCTextField *login;
@property BCTextField *password;
@property UIButton *button;
@property UILabel *forgotPasswordLabel;

@end
