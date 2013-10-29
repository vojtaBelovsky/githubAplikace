//
//  BCLabelColorImgView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 7/24/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCLabelColorImgView : UIImageView

@property UIImageView *maskImage;

-(void)setOrigin:(CGPoint)point;

@end
