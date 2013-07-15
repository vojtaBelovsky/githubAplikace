//
//  BCAddIssueTextField.h
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCAddIssueTextField : UITextField

@property UILabel *myLabel;
@property UITextField *textField;
@property UIImageView *separatorImgView;

- (id)initWithSize:(CGSize)size Title:(NSString *)title;

@end
