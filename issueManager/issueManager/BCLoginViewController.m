//
//  BCLoginViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLoginViewController.h"
#import "BCLoginView.h"
#import "BCHTTPClient.h"
#import "BCRepositoryViewController.h"

@interface BCLoginViewController ()

@end

@implementation BCLoginViewController

#pragma mark
#pragma mark lifeCycles

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self->_UIKeyboardWillShowNotification];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self->_UIKeyboardWillHideNotification];
    }
    return self;
}



- (void)loadView
{
    [super loadView];
    
    //
    // ------------ uncomment - will log in last user automaticly ------------
    //
    //    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *credentials = [userDefaults objectForKey:@"credentials"];
    //    if(credentials != NULL){
    //        [self.navigationController pushViewController:[[BCRepositoryViewController alloc] init] animated:YES];
    //    }else{
    _loginView = [[BCLoginView alloc] init];
    [_loginView.login setDelegate:self];
    [_loginView.password setDelegate:self];
    self.view = _loginView;
    self.navigationController.navigationBarHidden = YES;
    
    [_loginView.button addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchDown];
    //    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self->_UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self->_UIKeyboardWillHideNotification];
}

#pragma mark
#pragma mark keyboardManaging

- (void) keyboardWillHide:(NSNotification*)notification{//zmensi velikost skrolovatelneho obsahu
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGSize scrollContentSize = CGSizeMake(CGRectGetWidth(_loginView.frame), CGRectGetHeight(_loginView.frame)-keyboardFrameBeginRect.size.height);
    
    double animationDuration;
    animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        _loginView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        _loginView.contentSize = scrollContentSize;
    }];
}

- (void) keyboardWillShow:(NSNotification*)notification{//zvetsi velikost skrolovatelneho obsahu
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGSize scrollContentSize = CGSizeMake(CGRectGetWidth(_loginView.frame), CGRectGetHeight(_loginView.frame)+keyboardFrameBeginRect.size.height);
    
    _loginView.contentSize = scrollContentSize;
    double animationDuration;
    animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration delay:0.0f options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        _loginView.ContentOffset = CGPointMake(0, keyboardFrameBeginRect.size.height);
    } completion:nil];
}

#pragma mark
#pragma mark buttonActions

-(void)loginButton{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *credentials = [[NSDictionary alloc] initWithObjectsAndKeys:_loginView.login.text, @"login",_loginView.password.text, @"password", nil];
    [userDefaults setObject:credentials forKey:@"credentials"];
    [userDefaults synchronize];
    BCRepositoryViewController *repoViewCtrl = [[BCRepositoryViewController alloc] init];
    [self.navigationController pushViewController:repoViewCtrl animated:YES];
}

#pragma mark
#pragma mark textFieldHandling

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([textField isEqual:_loginView.login] || [textField isEqual:_loginView.password]){
        [textField resignFirstResponder];
    }
    return YES;
}

@end
