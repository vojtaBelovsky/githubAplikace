//
//  BCLableView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/2/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCLabel;

@interface BCLabelView : UIView

@property UILabel* myLabel;
@property UIView* whiteRect;

- (id)initWithLabel:(BCLabel*)label;

+(CGSize)sizeOfLabelWithText:(NSString*)text;

@end
