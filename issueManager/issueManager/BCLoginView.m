//
//  BCLoginView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLoginView.h"
#import "BCTextField.h"
#import "BCConstants.h"

#define RGB_COLOR(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f]

#define LOGIN_IMAGE     [UIImage imageNamed:@"loginButtonOff.png"]
#define LOGIN_HL_IMAGE  [UIImage imageNamed:@"loginButtonOn.png"]

#define BACKGROUND_IMAGE        [UIImage imageNamed:@"appBackground.png"]
#define FORGOT_PASSWORD_BACKGROUND  [UIColor clearColor]
#define LOGIN_BACKGROUND    [UIImage imageNamed:@"loginTextFieldTop.png"]
#define PASSWORD_BACKGROUND [UIImage imageNamed:@"loginTextFieldBottom.png"]

#define BUTTON_FONT               [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define FORGOT_PASSWORD_FONT      [UIFont fontWithName:@"ProximaNova-Regular" size:12]//[UIFont fontWithName:@"Proxima Nova Regular" size:24.0f]

#define EMPTY_TEXT_FIELD_FONT_COLOR      [UIColor colorWithRed:.68 green:.68 blue:.68 alpha:1.00]
#define FORGOT_PASSWD_FONT_COLOR         [UIColor colorWithRed:.68 green:.68 blue:.71 alpha:1.00]
#define FORGOT_PASSWD_TEXT_SHADOW_COLOR  [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.00]


#define LOGIN_TEXT_FIELD_HEIGHT_OFFSET  ( 0.5f )

#define TEXT_FIELD_WIDTH         ( 0.7f )
#define TEXT_FIELD_HEIGHT        ( 0.07f )
#define LOGIN_BUTTON_OFFSET      ( 0.05f )
#define FORGOT_PASSWD_OFFSET     ( 0.03f )

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
    
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_activityIndicatorView setColor:[UIColor blackColor]];
    [_activityIndicatorView setAlpha:ACTIVITY_INDICATOR_ALPHA];
    [_activityIndicatorView setBackgroundColor:ACTIVITY_INDICATOR_BACKGROUND];
    [self addSubview:_activityIndicatorView];
  }
  return self;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = self.frame.size;
  frame.origin = CGPointZero;
  if (!CGRectEqualToRect(_backgroundImageView.frame, frame)) {
    _backgroundImageView.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.width*TEXT_FIELD_WIDTH, self.frame.size.height*TEXT_FIELD_HEIGHT);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, self.frame.size.height*LOGIN_TEXT_FIELD_HEIGHT_OFFSET);
  if (!CGRectEqualToRect(_loginTextField.frame, frame)) {
    _loginTextField.frame = frame;
  }
  
  frame.size = _loginTextField.frame.size;
  frame.origin.y = CGRectGetMaxY(_loginTextField.frame);
  frame.origin.x = CGRectGetMinX(_loginTextField.frame);
  if(!CGRectEqualToRect(frame, _passwordTextField.frame)){
    _passwordTextField.frame = frame;
  }
  
  frame.size = _passwordTextField.frame.size;
  frame.origin = CGPointMake(_passwordTextField.frame.origin.x, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height+self.frame.size.height*LOGIN_BUTTON_OFFSET);
  if (!CGRectEqualToRect(_loginButton.frame, frame)) {
    _loginButton.frame = frame;
  }

  frame.size = [_forgotPasswordLabel sizeThatFits:self.frame.size];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, CGRectGetMaxY( _loginButton.frame ) + self.frame.size.height*FORGOT_PASSWD_OFFSET);
  if ( !CGRectEqualToRect( _forgotPasswordLabel.frame, frame ) ) {
    _forgotPasswordLabel.frame = frame;
  }
  
  frame.size = ACTIVITY_INDICATOR_SIZE;
  frame.origin = _activityIndicatorView.frame.origin;
  if (!CGRectEqualToRect(_activityIndicatorView.frame, frame)) {
    _activityIndicatorView.frame = frame;
  }
  
  if (!CGPointEqualToPoint(_activityIndicatorView.center, self.center)) {
    _activityIndicatorView.center = self.center;
  }
}

@end
