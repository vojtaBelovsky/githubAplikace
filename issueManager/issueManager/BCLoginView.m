//
//  BCLoginView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLoginView.h"
#import "BCTextField.h"

#define RGB_COLOR(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f]

#define LOGIN_IMAGE     [UIImage imageNamed:@"loginButtonOff.png"]
#define LOGIN_HL_IMAGE  [UIImage imageNamed:@"loginButtonOn.png"]
#define LOGO_IMAGE      [UIImage imageNamed:@"login_origo.png"]

#define BACKGROUND_IMAGE        [UIImage imageNamed:@"appBackground.png"]
#define OBRAZEK_PRO_POZICOVANI  [UIImage imageNamed:@"login_origo.png"]


#define BUTTON_FONT               [UIFont fontWithName:@"Proxima Nova Regular" size:36.0f]
#define FORGOT_PASSWORD_FONT      [UIFont fontWithName:@"Proxima Nova Regular" size:15.0f]
#define FORGOT_PASSWORD_BACKGROUND  [UIColor clearColor]
#define FORGOT_PASSWORD_COLOR       [UIColor grayColor]

#define TEXT_FIELD_SIZE   CGSizeMake ( 256.0f, 35.0f )
#define LOGIN_FIELD_Y     324.0f

#define LOGIN_ICON          [UIImage imageNamed:@"loginAccountIcon.png"]
#define PASSWORD_ICON       [UIImage imageNamed:@"loginLockerIcon.png"]

#define LOGIN_BACKGROUND    [UIImage imageNamed:@"loginTextFieldTop.png"]
#define PASSWORD_BACKGROUND [UIImage imageNamed:@"loginTextFieldBottom.png"]

@implementation BCLoginView

- (id)init {
  self = [super init];
  if (self) {
    UIImage *resizableImage = [BACKGROUND_IMAGE stretchableImageWithLeftCapWidth:5 topCapHeight:64];
    _background = [[UIImageView alloc] initWithImage:resizableImage];
    [self addSubview:_background];
    
    resizableImage = [LOGIN_IMAGE stretchableImageWithLeftCapWidth:18 topCapHeight:18];
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:resizableImage forState:UIControlStateNormal];
    resizableImage = [LOGIN_HL_IMAGE stretchableImageWithLeftCapWidth:18 topCapHeight:18];
    [_button setBackgroundImage:resizableImage forState:UIControlStateHighlighted];
    [_button setTitle:NSLocalizedString( @"Login", @"" ) forState:UIControlStateNormal];
    _button.titleLabel.font = BUTTON_FONT;
    [self addSubview:_button];
    
    _login = [[BCTextField alloc] initWithBackground:LOGIN_BACKGROUND icon:LOGIN_ICON];
    [self addSubview:_login];
    
    _password = [[BCTextField alloc] initWithBackground:PASSWORD_BACKGROUND icon:PASSWORD_ICON];
    _password.textField.secureTextEntry = YES;
    
    _forgotPasswordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _forgotPasswordLabel.backgroundColor = FORGOT_PASSWORD_BACKGROUND;
    _forgotPasswordLabel.text = NSLocalizedString( @"Forgot password?", @"" );
    _forgotPasswordLabel.font = FORGOT_PASSWORD_FONT;
    _forgotPasswordLabel.numberOfLines = 0;
    _forgotPasswordLabel.textColor = FORGOT_PASSWORD_COLOR;
    _forgotPasswordLabel.userInteractionEnabled = YES;
    
    [self addSubview:_forgotPasswordLabel];
    [self addSubview:_password];
  }
  return self;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  
  CGRect backgroundFrame = CGRectZero;
  backgroundFrame.size = self.bounds.size;
  if ( !CGRectEqualToRect( backgroundFrame, _background.frame ) ) {
    _background.frame = backgroundFrame;
  }
  
  CGRect loginFrame = CGRectZero;
  loginFrame.size = TEXT_FIELD_SIZE;
  loginFrame.origin.x = ( CGRectGetWidth( self.bounds ) - CGRectGetWidth( loginFrame ) ) / 2;
  loginFrame.origin.y = LOGIN_FIELD_Y;
  if(!CGRectEqualToRect(loginFrame, _login.frame)){
    _login.frame = loginFrame;
  }
  
  CGRect passwordFrame = CGRectZero;
  passwordFrame.size = TEXT_FIELD_SIZE;
  passwordFrame.origin.x = CGRectGetMinX( loginFrame );
  passwordFrame.origin.y = CGRectGetMaxY( loginFrame );
  if(!CGRectEqualToRect(passwordFrame, _password.frame)){
    _password.frame = passwordFrame;
  }
  
  CGRect buttonFrame = CGRectMake(32, 410, 258, 32);
  if(!CGRectEqualToRect(buttonFrame, _button.frame)){
    _button.frame = buttonFrame;
  }

  CGRect forgotPasswordFrame;
  forgotPasswordFrame.size = [_forgotPasswordLabel sizeThatFits:CGSizeMake( CGRectGetWidth( self.frame ), 15.0f )];
  forgotPasswordFrame.origin.x = ( CGRectGetWidth( self.frame ) - CGRectGetWidth( forgotPasswordFrame ) ) / 2;
  forgotPasswordFrame.origin.y = CGRectGetMaxY( _button.frame ) + 10.0f;
  if ( !CGRectEqualToRect( _forgotPasswordLabel.frame, forgotPasswordFrame ) ) {
    _forgotPasswordLabel.frame = forgotPasswordFrame;
  }
  
}

@end
