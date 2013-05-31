//
//  BCLoginViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLoginViewController.h"
#import "BCLoginView.h"

@interface BCLoginViewController ()

@end

@implementation BCLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    _loginView = [[BCLoginView alloc] init];
    [_loginView.login setDelegate:self];
    [_loginView.password setDelegate:self];
    self.view = _loginView;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([textField isEqual:_loginView.login] || [textField isEqual:_loginView.password]){
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
