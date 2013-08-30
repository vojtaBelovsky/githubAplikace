
//
//  UIAlertView+errorAlert.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "UIAlertView+errorAlert.h"

@implementation UIAlertView (errorAlert)

+(UIAlertView*) showWithError:(NSError*) error {
  
  NSString *myStr = [[error localizedRecoverySuggestion] substringFromIndex:[@"{\"message\":\"" length]];
  myStr = [myStr substringToIndex:([myStr length]-2)];
  UIAlertView *alert = [[UIAlertView alloc]
                        initWithTitle:myStr
                        message:nil
                        delegate:nil
                        cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                        otherButtonTitles:nil];
  
  [alert show];
  return alert;
}

@end
