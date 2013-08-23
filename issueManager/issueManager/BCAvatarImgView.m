//
//  BCAvatarImgView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCAvatarImgView.h"

#define CORP_MASK           [UIImage imageNamed:@"40x40.png"]

@implementation BCAvatarImgView

- (id)init
{
  self = [super init];
  if (self) {    
    _maskImageView = [[UIImageView alloc] initWithImage:CORP_MASK];
    [self addSubview:_maskImageView];
  }
  return self;
}

-(void)setFrame:(CGRect)frame{
  [super setFrame:frame];
  [_maskImageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

 -(void)setMaskImageView:(UIImageView *)maskImageView{
  _maskImageView = maskImageView;
  _maskImageView.frame = self.frame;
}



@end
