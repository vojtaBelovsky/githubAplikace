//
//  BCLoginViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCLoginView;

@interface BCLoginViewController : UIViewController<UITextFieldDelegate>{
@private
    BCLoginView *_loginView;
}

@end
