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

#define CORP_MASK           [UIImage imageNamed:@"40x40.png"]
#define CORP_MASK2           [UIImage imageNamed:@"40x40.png"]

@implementation BCLabelColorImgView

- (id)init
{
  self = [super init];
  if (self) {
    CGRect frame = CGRectMake(0, 0, AVATAR_WIDTH, AVATAR_HEIGHT);
    [self setFrame:frame];
    
    self.maskImage = [[UIImageView alloc] initWithImage:CORP_MASK];// highlightedImage:CORP_MASK2];
    [self.maskImage setFrame:frame];
    [self addSubview:self.maskImage];
  }
  return self;
}

-(void)setOrigin:(CGPoint)point{
  [self setFrame:CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height)];
}

@end
