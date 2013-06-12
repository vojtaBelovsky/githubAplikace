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

@property UIImageView *backgroundImageView;
@property BCTextField *loginTextField;
@property BCTextField *passwordTextField;
@property UIButton *loginButton;
@property UILabel *forgotPasswordLabel;

@end
