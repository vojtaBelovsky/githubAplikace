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
#import "UIAlertView+errorAlert.h"
#import "BCAppDelegate.h"
#import "TMViewDeckController.h"

#define VIEW_OFFSET         ( - 150.0f )
#define ANIMATION_DURATION  0.2f

#define FILLED_TEXT_FIELD_FONT_COLOR     [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00];

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
//  [super loadView];
  
  //
  // ------------ uncomment - will log in last user automaticly ------------
  //
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSDictionary *credentials = [userDefaults objectForKey:@"credentials"];
  if(credentials != NULL){
    [BCUser sharedInstanceChangeableWithUser:nil succes:^(BCUser *user) {
      BCRepositoryViewController *repoViewCtrl = [[BCRepositoryViewController alloc] init];
      BCAppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
      [myDelegate.deckController setCenterController:repoViewCtrl];
//      [self.navigationController pushViewController:repoViewCtrl animated:YES];
    } failure:^(NSError *error) {
      [UIAlertView showWithError:error];
    }];
  }else{
    _loginView = [[BCLoginView alloc] init];
    [_loginView.loginTextField.textField setDelegate:self];
    [_loginView.passwordTextField.textField setDelegate:self];
    
    self.view = _loginView;
    [self.navigationController setNavigationBarHidden:YES];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPasswordDidPress)];
    [_loginView.forgotPasswordLabel addGestureRecognizer:tgr];
    
    [_loginView.loginButton addTarget:self action:@selector(loginButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  }
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
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSDictionary *credentials = [[NSDictionary alloc] initWithObjectsAndKeys:_loginView.loginTextField.textField.text, @"login",_loginView.passwordTextField.textField.text, @"password", nil];
  [userDefaults setObject:credentials forKey:@"credentials"];
  [userDefaults synchronize];
  
  [BCUser sharedInstanceChangeableWithUser:nil succes:^(BCUser *user){
    BCRepositoryViewController *repoViewCtrl = [[BCRepositoryViewController alloc] init];
    BCAppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    [myDelegate.deckController setCenterController:repoViewCtrl];
//    [self.navigationController pushViewController:repoViewCtrl animated:YES];
  } failure:^(NSError *error){
    [UIAlertView showWithError:error];
  }];
}

- (void)forgotPasswordDidPress {
  [self hideKeyboard];
  
#warning Dopsta funkcionalitu
}

- (void)hideKeyboard {
  [_loginView.loginTextField.textField resignFirstResponder];
  [_loginView.passwordTextField.textField resignFirstResponder];
  
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
#pragma mark textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  if ([textField isEqual:_loginView.loginTextField.textField]) {
    [_loginView.passwordTextField.textField becomeFirstResponder];
  }
  if ([textField isEqual:_loginView.passwordTextField.textField]) {
    [self loginButtonDidPress];
  }
  return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {//changing text colours and setting offset
  
  if ([textField isEqual:_loginView.loginTextField.textField]){
    _loginView.loginTextField.textField.textColor = FILLED_TEXT_FIELD_FONT_COLOR;
  }
  
  if ([textField isEqual:_loginView.passwordTextField.textField]){
    _loginView.passwordTextField.textField.textColor = FILLED_TEXT_FIELD_FONT_COLOR;
  }
  
  CGRect frame = self.view.frame;
  
  if ( CGRectGetMinY( frame ) == VIEW_OFFSET ) {
    return;
  }
  
  frame.origin.y = VIEW_OFFSET;
  [self animateViewWithFrame:frame];
}

@end
