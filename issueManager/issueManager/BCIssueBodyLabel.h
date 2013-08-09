//
//  BCIssueBodyLabel.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCIssueBodyLabel : UILabel

-(CGSize)sizeOfLabel;

+(CGSize)sizeOfLabelWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font;

@end
