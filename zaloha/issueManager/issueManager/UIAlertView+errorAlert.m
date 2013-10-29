
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
  
  UIAlertView *alert = [[UIAlertView alloc]
                        initWithTitle:@"ERROR"
                        message:[error localizedDescription]
                        delegate:nil
                        cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                        otherButtonTitles:nil];
  
  [alert show];
  return alert;
}

@end
