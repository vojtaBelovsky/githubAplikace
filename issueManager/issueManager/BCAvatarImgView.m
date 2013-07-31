//
//  BCAvatarImgView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCAvatarImgView.h"

#define AVATAR_WIDTH    ( 24.0f )
#define AVATAR_HEIGHT   ( 24.0f )

#define CORP_MASK           [UIImage imageNamed:@"40x40.png"]

@implementation BCAvatarImgView

- (id)init
{
  self = [super init];
  if (self) {
    CGRect frame = CGRectMake(0, 0, AVATAR_WIDTH, AVATAR_HEIGHT);
    [self setFrame:frame];
    
    _maskImageView = [[UIImageView alloc] initWithImage:CORP_MASK];
    [_maskImageView setFrame:frame];
    [self addSubview:_maskImageView];
  }
  return self;
}

-(void)setOrigin:(CGPoint)point{
  [self setFrame:CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height)];
}

@end
