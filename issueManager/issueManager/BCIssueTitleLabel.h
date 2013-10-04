//
//  BCIssueTitleLabel.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/5/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#define LINE_HEIGHT 17

#import <UIKit/UIKit.h>
#import "MTLabel.h"

@interface BCIssueTitleLabel : MTLabel

- (id)initWithFont:(UIFont*)font;

-(CGSize)sizeOfLabelWithWidth:(CGFloat)width;

+(CGSize)sizeOfLabelWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width;

+(NSString *)getLastLineInLabelFromText:(NSString *)givenText;

-(NSString *)getLastLineOfStringInLabel;

@end
