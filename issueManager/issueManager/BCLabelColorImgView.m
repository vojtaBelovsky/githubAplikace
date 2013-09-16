//
//  BCLabelColorImgView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/24/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLabelColorImgView.h"

#define AVATAR_WIDTH    ( 24.0f )
#define AVATAR_HEIGHT   ( 24.0f )

#define CORP_MASK       [UIImage imageNamed:@"40x40.png"]
#define GRAY_COLOR      [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.00]

#define brightnessLeve(r,g,b) 0.299*r + 0.587*g + 0.114*b

@implementation BCLabelColorImgView

- (id)init
{
  self = [super init];
  if (self) {
    CGRect frame = CGRectMake(0, 0, AVATAR_WIDTH, AVATAR_HEIGHT);
    [self setFrame:frame];
    
    self.maskImage = [[UIImageView alloc] initWithImage:CORP_MASK];
    [self.maskImage setFrame:frame];
    [self addSubview:self.maskImage];
  }
  return self;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
  CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
  [backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
  if (brightnessLeve(red, green, blue) > 0.9) {
    backgroundColor = GRAY_COLOR;
  }
  [super setBackgroundColor:backgroundColor];
}

-(void)setFrame:(CGRect)frame{
  [super setFrame:frame];
  [_maskImage setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

-(void)setOrigin:(CGPoint)point{
  [self setFrame:CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height)];
}

@end
