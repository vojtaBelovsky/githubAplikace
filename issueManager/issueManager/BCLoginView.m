//
//  BCLoginView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLoginView.h"

#define RGB_COLOR(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f]

@implementation BCLoginView

- (id)init
{
    self = [super init];
    if (self) {
        _background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login.png"]];
        [self addSubview:_background];
        
        self.backgroundColor = RGB_COLOR(232, 232, 232, 91);
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        //_button setImage:<#(UIImage *)#> forState:<#(UIControlState)#>
        //NASTAVENI ZMACKUNETHO A NEZMACKNUTEHO TLACITKA
        [self addSubview:_button];
        
        _login = [[UITextField alloc] init];
        _login.backgroundColor = [UIColor whiteColor];
        [self addSubview:_login];
        
        _password = [[UITextField alloc] init];
        _password.backgroundColor = [UIColor whiteColor];
        _password.secureTextEntry = YES;
        [self addSubview:_password];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect backgroundFrame = self.frame;
    if(!CGRectEqualToRect(backgroundFrame, _background.frame)){
        _background.frame = backgroundFrame;
    }
    
    CGRect loginFrame = CGRectMake(80, 292, 200, 24);
    if(!CGRectEqualToRect(loginFrame, _login.frame)){
        _login.frame = loginFrame;
    }
    
    CGRect passwordFrame = CGRectMake(80, 319, 200, 24);
    if(!CGRectEqualToRect(passwordFrame, _password.frame)){
        _password.frame = passwordFrame;
    }
    
    CGRect buttonFrame = CGRectMake(32, 358, 258, 32);
    if(!CGRectEqualToRect(buttonFrame, _button.frame)){
        _button.frame = buttonFrame;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
