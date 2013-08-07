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

#define REGULAR_FONT_SMALL  [UIFont fontWithName:@"ProximaNova-Regular" size:13]
#define MAXIMUM_WIDTH       ( 150.0f )
#define LABEL_TEXT_OFFSET   ( 7.0f )
#define LABELS_OFFSET       ( 4.0f )

@implementation BCLabelView

- (id)initWithLabel:(BCLabel*)label
{
  self = [super init];
  if (self) {
    [self.layer setBorderWidth:1];
    [self.layer setBorderColor:label.color.CGColor];
    [self.layer setCornerRadius:5];
    [self.layer setBackgroundColor:label.color.CGColor];
    
    _myLabel = [[UILabel alloc] init];
    [_myLabel setFont:REGULAR_FONT_SMALL];
    [_myLabel setTextColor:[UIColor whiteColor]];
    [_myLabel setText:label.name];
    [_myLabel setBackgroundColor:[UIColor clearColor]];
    CGRect frame;
    frame.size = [_myLabel.text sizeWithFont:REGULAR_FONT_SMALL];
    frame.size.width = MIN(frame.size.width, MAXIMUM_WIDTH);
    [_myLabel setFrame:frame];
    [self addSubview:_myLabel];
    
    frame.origin = CGPointZero;
    frame.size.height += LABEL_TEXT_OFFSET;
    frame.size.width += LABEL_TEXT_OFFSET;
    [self setFrame:frame];
    
    frame.origin.x += 1;
    frame.origin.y += 1;
    frame.size.width -= 2;
    frame.size.height -= 2;
    _whiteRect = [[UIView alloc] initWithFrame:frame];
    [_whiteRect setBackgroundColor:[UIColor whiteColor]];
    _whiteRect.alpha = 0.4;
    [self addSubview:_whiteRect];
  }
  return self;
}

+(CGSize)sizeOfLabelWithText:(NSString*)text{
  CGSize mySize = [text sizeWithFont:REGULAR_FONT_SMALL];
  mySize.width += (2*LABEL_TEXT_OFFSET)+LABELS_OFFSET;
  mySize.height += (2*LABEL_TEXT_OFFSET);
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
