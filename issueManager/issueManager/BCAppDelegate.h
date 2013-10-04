//
//  BCAppDelegate.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/19/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMViewDeckController;
@class BCRepositoryViewController;

@interface BCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) TMViewDeckController *deckController;
@end
