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
#define HASH_FONT         [UIFont fontWithName:@"ProximaNova-Bold" size:12]

#define HASH_NUMBER_OFFSET      ( 2.0f )
#define MAX_HASH_NUMBER_WIDTH   ( 24.0f )

@implementation BCIssueNumberView

- (id)init
{
  self = [super init];
  if (self) {
    UIImage *image = [BACKGROUND_IMG stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    _backgroundRectangle = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_backgroundRectangle];
    
    _hashNumber = [[UILabel alloc] init];
    [_hashNumber setFont:HASH_FONT];
    [_hashNumber setTextColor:HASH_FONT_COLOR];
    _hashNumber.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_hashNumber];
  }
  return self;
}

-(void)layoutSubviews{
  CGRect frame = CGRectZero;
  
  frame.size = self.frame.size;
  if (!CGRectEqualToRect(_backgroundRectangle.frame, frame)) {
    _backgroundRectangle.frame = frame;
  }
  
  frame.size = [_hashNumber sizeThatFits:self.frame.size];
  frame.size.width = MIN(frame.size.width, MAX_HASH_NUMBER_WIDTH);
  frame.origin = CGPointMake((self.frame.size.width-_hashNumber.frame.size.width)/2, (self.frame.size.height-_hashNumber.frame.size.height)/2);
  if (!CGRectEqualToRect(_hashNumber.frame, frame)) {
    _hashNumber.frame = frame;
  }
}

@end
