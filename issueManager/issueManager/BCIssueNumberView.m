//
//  BCIssueNumberView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/2/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueNumberView.h"

#define BACKGROUND_IMG    [UIImage imageNamed:@"profileHashBorder.png"]
#define HASH_FONT_COLOR   [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]
#define HASH_FONT         [UIFont fontWithName:@"ProximaNova-Bold" size:13]

@implementation BCIssueNumberView

- (id)init
{
  self = [super init];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    UIImage *image = [BACKGROUND_IMG stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    _backgroundRectangle = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_backgroundRectangle];
    
    _hashNumber = [[UILabel alloc] init];
    [_hashNumber setFont:HASH_FONT];
    [_hashNumber setTextColor:HASH_FONT_COLOR];
    [_hashNumber setBackgroundColor:[UIColor clearColor]];
    [_hashNumber setTextAlignment:NSTextAlignmentCenter];
    _hashNumber.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_hashNumber];
  }
  return self;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame = CGRectZero;
  
  frame.size = self.frame.size;
  if (!CGRectEqualToRect(_backgroundRectangle.frame, frame)) {
    _backgroundRectangle.frame = frame;
  }
  
  frame.size = [_hashNumber sizeThatFits:self.frame.size];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.frame.size.height-frame.size.height)/2+1);
  if (!CGRectEqualToRect(_hashNumber.frame, frame)) {
    _hashNumber.frame = frame;
  }
}

@end
