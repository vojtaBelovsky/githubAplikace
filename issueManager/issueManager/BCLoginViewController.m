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
#import "BCUser.h"
#import "BCTextField.h"

#define VIEW_OFFSET         ( - 150.0f )
#define ANIMATION_DURATION  0.2f

@interface BCLoginViewController ()
- (void)animateViewWithFrame:(CGRect)frame;
- (void)loginButtonDidPress;
- (void)forgotPasswordDidPress;
- (void)hideKeyboard;
@end

@implementation BCLoginViewController

#pragma mark
#pragma mark lifeCycles

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}



- (void)loadView {
  [super loadView];
    
    //
    // ------------ uncomment - will log in last user automaticly ------------
    //
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *credentials = [userDefaults objectForKey:@"credentials"];
//    if(credentials != NULL){
//      [BCUser sharedInstanceChangeableWithUser:nil completion:^(BCUser *user){
//        BCRepositoryViewController *repoViewCtrl = [[BCRepositoryViewController alloc] initWithUser:user];
//        [self.navigationController pushViewController:repoViewCtrl animated:YES];
//      }];
//    }else{
  _loginView = [[BCLoginView alloc] init];
  [_loginView.login.textField setDelegate:self];
  [_loginView.password.textField setDelegate:self];
  
  self.view = _loginView;
  self.navigationController.navigationBarHidden = YES;
  
  UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPasswordDidPress)];
  [_loginView.forgotPasswordLabel addGestureRecognizer:tgr];
  
  [_loginView.button addTarget:self action:@selector(loginButtonDidPress) forControlEvents:UIControlEventTouchDown];
//    }
}

#pragma mark -
#pragma mark Private

- (void)animateViewWithFrame:(CGRect)frame {
  __weak BCLoginViewController *weakSelf = self;
  [UIView animateWithDuration:ANIMATION_DURATION delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^ {
    weakSelf.view.frame = frame;
  } completion:nil];  
}

- (void)loginButtonDidPress {
  [BCUser sharedInstanceChangeableWithUser:nil completion:^(BCUser *user){
    BCRepositoryViewController *repoViewCtrl = [[BCRepositoryViewController alloc] initWithUser:user];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *credentials = [[NSDictionary alloc] initWithObjectsAndKeys:_loginView.login.textField.text, @"login",_loginView.password.textField.text, @"password", nil];
    [userDefaults setObject:credentials forKey:@"credentials"];
    [userDefaults synchronize];
    
    [self.navigationController pushViewController:repoViewCtrl animated:YES];
  }];
}

- (void)forgotPasswordDidPress {
  [self hideKeyboard];
  
#warning Dopsta funkcionalitu
}

- (void)hideKeyboard {
  [_loginView.login.textField resignFirstResponder];
  [_loginView.password.textField resignFirstResponder];
  
  CGRect frame = self.view.frame;
  frame.origin.y = 0.0f;
  
  [self animateViewWithFrame:frame];
}

#pragma mark -
#pragma mark UIResponder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];
  
}

#pragma mark
#pragma mark textFieldHandling

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  CGRect frame = self.view.frame;
  if ( CGRectGetMinY( frame ) == VIEW_OFFSET ) {
    return;
  }
  
  frame.origin.y = VIEW_OFFSET;
  [self animateViewWithFrame:frame];
}

@end
