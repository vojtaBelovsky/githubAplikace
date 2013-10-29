//
//  BCLableView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/2/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCLabelView.h"
#import <QuartzCore/QuartzCore.h>
#import "BCLabel.h"

#define REGULAR_FONT_SMALL  [UIFont fontWithName:@"ProximaNova-Regular" size:9]
#define MAXIMUM_WIDTH       ( 80.0f )
#define TOP_TEXT_OFFSET     ( 2.0f )
#define LEFT_TEXT_OFFSET    ( 4.0f )
#define CORNER_RADIUS       ( 4.0f )

#define WHITE_COLOR         [UIColor whiteColor]
#define BLACK_COLOR         [UIColor blackColor]
#define GRAY_COLOR          [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.00]

#define brightnessLeve(r,g,b) 0.299*r + 0.587*g + 0.114*b

@implementation BCLabelView

- (id)initWithLabel:(BCLabel*)label
{
  self = [super init];
  if (self) {
    [self.layer setBorderWidth:1];
    [self.layer setBorderColor:label.color.CGColor];
    [self.layer setCornerRadius:CORNER_RADIUS];
    [self.layer setBackgroundColor:label.color.CGColor];
    
    UIColor *textColor;
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [label.color getRed:&red green:&green blue:&blue alpha:&alpha];
    if (brightnessLeve(red, green, blue) > 0.5) {
      textColor = BLACK_COLOR;
    }else{
      textColor = WHITE_COLOR;
    }
    
    if (brightnessLeve(red, green, blue) > 0.8) {
      [self.layer setBorderColor:GRAY_COLOR.CGColor];
      [self.layer setBackgroundColor:GRAY_COLOR.CGColor];
    }
    
    _myLabel = [[UILabel alloc] init];
    [_myLabel setFont:REGULAR_FONT_SMALL];
    [_myLabel setTextColor:textColor];
    [_myLabel setText:label.name];
    [_myLabel setBackgroundColor:[UIColor clearColor]];
    CGRect frame;
    frame.size = [_myLabel.text sizeWithFont:REGULAR_FONT_SMALL];
    frame.size.width = MIN(frame.size.width, MAXIMUM_WIDTH);
    [_myLabel setFrame:frame];
    [self addSubview:_myLabel];
    
    frame.origin = CGPointZero;
    frame.size.height += 2*TOP_TEXT_OFFSET;
    frame.size.width += 2*LEFT_TEXT_OFFSET;
    [self setFrame:frame];
    
    frame.origin.x += 1;
    frame.origin.y += 1;
    frame.size.width -= 2;
    frame.size.height -= 2;
    _whiteRect = [[UIView alloc] initWithFrame:frame];
    [_whiteRect setBackgroundColor:[UIColor whiteColor]];
    _whiteRect.alpha = 0.3;
    [self addSubview:_whiteRect];
  }
  return self;
}

+(CGSize)sizeOfLabelWithText:(NSString*)text{
  CGSize mySize = [text sizeWithFont:REGULAR_FONT_SMALL];
  mySize.width = MIN(mySize.width, MAXIMUM_WIDTH);
  mySize.width += 2*LEFT_TEXT_OFFSET;
  mySize.height += 2*TOP_TEXT_OFFSET;
  return mySize;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  frame.size = _myLabel.frame.size;
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_myLabel.frame, frame)) {
    _myLabel.frame = frame;
  }
}

@end
