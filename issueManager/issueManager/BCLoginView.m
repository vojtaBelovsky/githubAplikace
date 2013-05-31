//
//  BCLoginView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLoginView.h"

@implementation BCLoginView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_button setTitle:@"Banan" forState:UIControlStateNormal];
        [self addSubview:_button];
        
        _login = [[UITextField alloc] init];
        [self addSubview:_login];
        
        _password = [[UITextField alloc] init];
        [self addSubview:_password];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect loginFrame = CGRectMake(0, 0, 200, 20);
    if(!CGRectEqualToRect(loginFrame, _login.frame)){
        _login.frame = loginFrame;
    }
    
    CGRect passwordFrame = CGRectMake(200, 300, 200, 20);
    if(!CGRectEqualToRect(passwordFrame, _password.frame)){
        _password.frame = passwordFrame;
    }
    
    CGRect buttonFrame = CGRectMake(50, 150, 50, 20);
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
