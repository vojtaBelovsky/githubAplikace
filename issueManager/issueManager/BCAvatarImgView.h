//
//  BCAvatarImgView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 7/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCAvatarImgView : UIImageView{
@private
  UIImageView *_maskImageView;
}

-(void)setOrigin:(CGPoint)point;

@end
