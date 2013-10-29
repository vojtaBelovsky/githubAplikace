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
#define HASH_FONT         [UIFont fontWithName:@"ProximaNova-Bold" size:11]

#define SIZE_FOR_ONE_TO_THREE_DIGIT      CGSizeMake(26,16)
#define SIZE_FOR_FOUR_AND_MORE_DIGITS    CGSizeMake(30,16)

@implementation BCIssueNumberView

- (id)init
{
  self = [super init];
  if (self) {
    _issueNumber = [NSNumber numberWithInt:0];
    [self setBackgroundColor:[UIColor clearColor]];
    UIImage *image = [BACKGROUND_IMG stretchableImageWithLeftCapWidth:8 topCapHeight:0];
    _backgroundRectangle = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_backgroundRectangle];
    
    _hashNumber = [[UILabel alloc] init];
    [_hashNumber setFont:HASH_FONT];
    [_hashNumber setTextColor:HASH_FONT_COLOR];
    [_hashNumber setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_hashNumber];
  }
  return self;
}

-(CGSize)countMySize{
  if (![_issueNumber intValue]/1000) {
    return SIZE_FOR_FOUR_AND_MORE_DIGITS;
  }
  return SIZE_FOR_ONE_TO_THREE_DIGIT;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame = CGRectZero;
  
  frame.size = self.frame.size;
  if (!CGRectEqualToRect(_backgroundRectangle.frame, frame)) {
    _backgroundRectangle.frame = frame;
  }
  
  frame.size = [_hashNumber.text sizeWithFont:HASH_FONT];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2+0.5, (self.frame.size.height-frame.size.height)/2+0.5);
  if (!CGRectEqualToRect(_hashNumber.frame, frame)) {
    _hashNumber.frame = frame;
  }
}

@end
