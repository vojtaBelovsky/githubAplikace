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

#define BACKGROUND_IMAGE        [UIImage imageNamed:@"appBackground.png"]
#define FORGOT_PASSWORD_BACKGROUND  [UIColor clearColor]
#define LOGIN_BACKGROUND    [UIImage imageNamed:@"loginTextFieldTop.png"]
#define PASSWORD_BACKGROUND [UIImage imageNamed:@"loginTextFieldBottom.png"]

#define BUTTON_FONT               [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define FORGOT_PASSWORD_FONT      [UIFont fontWithName:@"ProximaNova-Regular" size:12]//[UIFont fontWithName:@"Proxima Nova Regular" size:24.0f]

#define EMPTY_TEXT_FIELD_FONT_COLOR      [UIColor colorWithRed:.68 green:.68 blue:.68 alpha:1.00];
#define LOGIN_BUTTON_FONT_COLOR          [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:];
#define LOGIN_BUTTON_TEXT_SHADOW_COLOR   [UIColor colorWithRed:.14 green:.42 blue:.65 alpha:1.00];
#define FORGOT_PASSWD_FONT_COLOR         [UIColor colorWithRed:.68 green:.68 blue:.71 alpha:1.00];
#define FORGOT_PASSWD_TEXT_SHADOW_COLOR  [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.00];

#define TEXT_FIELD_SIZE   CGSizeMake ( 256.0f, 35.0f )
#define LOGIN_FIELD_Y     324.0f

#define LOGIN_ICON          [UIImage imageNamed:@"loginAccountIcon.png"]
#define PASSWORD_ICON       [UIImage imageNamed:@"loginLockerIcon.png"]

@implementation BCLoginView

- (id)init {
  self = [super init];
  if (self) {
    UIImage *resizableImage = [BACKGROUND_IMAGE stretchableImageWithLeftCapWidth:5 topCapHeight:64];
    _backgroundImageView = [[UIImageView alloc] initWithImage:resizableImage];
    [self addSubview:_backgroundImageView];
    
    resizableImage = [LOGIN_IMAGE stretchableImageWithLeftCapWidth:18 topCapHeight:18];
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setBackgroundImage:resizableImage forState:UIControlStateNormal];
    resizableImage = [LOGIN_HL_IMAGE stretchableImageWithLeftCapWidth:18 topCapHeight:18];
    [_loginButton setBackgroundImage:resizableImage forState:UIControlStateHighlighted];
    [_loginButton setTitle:NSLocalizedString( @"Login", @"" ) forState:UIControlStateNormal];
    _loginButton.titleLabel.font = BUTTON_FONT;
    [self addSubview:_loginButton];
    
    _loginTextField = [[BCTextField alloc] initWithBackground:LOGIN_BACKGROUND icon:LOGIN_ICON];
    _loginTextField.textField.placeholder = NSLocalizedString( @"Login", @"" );
    _loginTextField.textField.textColor = EMPTY_TEXT_FIELD_FONT_COLOR;
    _loginTextField.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _loginTextField.textField.ReturnKeyType = UIReturnKeyNext;
    [self addSubview:_loginTextField];
    
    _passwordTextField = [[BCTextField alloc] initWithBackground:PASSWORD_BACKGROUND icon:PASSWORD_ICON];
    _passwordTextField.textField.placeholder = NSLocalizedString( @"Password", @"" );
    _passwordTextField.textField.textColor = EMPTY_TEXT_FIELD_FONT_COLOR;
    _passwordTextField.textField.secureTextEntry = YES;
    [self addSubview:_passwordTextField];
    
    _forgotPasswordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _forgotPasswordLabel.backgroundColor = FORGOT_PASSWORD_BACKGROUND;
    _forgotPasswordLabel.text = NSLocalizedString( @"Forgot password?", @"" );
    _forgotPasswordLabel.font = FORGOT_PASSWORD_FONT;
    _forgotPasswordLabel.numberOfLines = 0;
    _forgotPasswordLabel.textColor = FORGOT_PASSWD_FONT_COLOR;
    _forgotPasswordLabel.shadowColor = FORGOT_PASSWD_TEXT_SHADOW_COLOR;
    _forgotPasswordLabel.userInteractionEnabled = YES;
    [self addSubview:_forgotPasswordLabel];
  }
  return self;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  
  CGRect backgroundFrame = CGRectZero;
  backgroundFrame.size = self.bounds.size;
  if ( !CGRectEqualToRect( backgroundFrame, _backgroundImageView.frame ) ) {
    _backgroundImageView.frame = backgroundFrame;
  }
  
  CGRect loginFrame = CGRectZero;
  loginFrame.size = TEXT_FIELD_SIZE;
  loginFrame.origin.x = ( CGRectGetWidth( self.bounds ) - CGRectGetWidth( loginFrame ) ) / 2;
  loginFrame.origin.y = LOGIN_FIELD_Y;
  if(!CGRectEqualToRect(loginFrame, _loginTextField.frame)){
    _loginTextField.frame = loginFrame;
  }
  
  CGRect passwordFrame = CGRectZero;
  passwordFrame.size = TEXT_FIELD_SIZE;
  passwordFrame.origin.x = CGRectGetMinX( loginFrame );
  passwordFrame.origin.y = CGRectGetMaxY( loginFrame );
  if(!CGRectEqualToRect(passwordFrame, _passwordTextField.frame)){
    _passwordTextField.frame = passwordFrame;
  }
  
  CGRect buttonFrame = CGRectMake(32, 410, 258, 32);
  if(!CGRectEqualToRect(buttonFrame, _loginButton.frame)){
    _loginButton.frame = buttonFrame;
  }

  CGRect forgotPasswordFrame;
  forgotPasswordFrame.size = [_forgotPasswordLabel sizeThatFits:CGSizeMake( CGRectGetWidth( self.frame ), 15.0f )];
  forgotPasswordFrame.origin.x = ( CGRectGetWidth( self.frame ) - CGRectGetWidth( forgotPasswordFrame ) ) / 2;
  forgotPasswordFrame.origin.y = CGRectGetMaxY( _loginButton.frame ) + 10.0f;
  if ( !CGRectEqualToRect( _forgotPasswordLabel.frame, forgotPasswordFrame ) ) {
    _forgotPasswordLabel.frame = forgotPasswordFrame;
  }
  
}

@end
