//
//  BCTextField.h
//  issueManager
//
//  Created by Vojtech Belovsky on 6/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCTextField : UIView <UITextInputTraits>{
@private
  UIImageView *_backgroundView;
  UIImageView *_iconView;
}

@property (strong) UITextField *textField;

- (id)initWithBackground:(UIImage *)backgroundImage icon:(UIImage *)iconImage;

@end
