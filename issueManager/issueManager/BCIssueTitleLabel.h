//
//  BCIssueTitleLabel.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/5/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCIssueTitleLabel : UILabel

- (id)initWithFont:(UIFont*)font andColor:(UIColor*)color;

+(CGSize)sizeOfLabelWithText:(NSString*)string withFont:(UIFont*)font;
  
@end
