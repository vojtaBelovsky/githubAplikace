//
//  UIAlertView+errorAlert.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (errorAlert)

+(UIAlertView*) showWithError:(NSError*) error;

@end
