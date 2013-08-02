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

#define REGULAR_FONT_SMALL  [UIFont fontWithName:@"ProximaNova-Regular" size:10]
#define MAXIMUM_WIDTH       ( 150.0f )
#define LABEL_TEXT_OFFSET   ( 5.0f )

@implementation BCLabelView

- (id)initWithLabel:(BCLabel*)label
{
  self = [super init];
  if (self) {
    [self.layer setBorderWidth:5];
    [self.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.layer setCornerRadius:5];
    [self.layer setBackgroundColor:label.color.CGColor];
    [self setBackgroundColor:[UIColor greenColor]];
    
    _myLabel = [[UILabel alloc] init];
    [_myLabel setTextColor:[UIColor whiteColor]];
    [_myLabel setText:label.name];
    CGRect frame;
    frame.size = [_myLabel.text sizeWithFont:REGULAR_FONT_SMALL];
    frame.size.width = MIN(frame.size.width, MAXIMUM_WIDTH);
    frame.origin = CGPointMake(LABEL_TEXT_OFFSET, LABEL_TEXT_OFFSET);
    [_myLabel setFrame:frame];
    [self addSubview:_myLabel];
    
    frame.origin = CGPointZero;
    frame.size.height += LABEL_TEXT_OFFSET;
    frame.size.width += LABEL_TEXT_OFFSET;
    [self setFrame:frame];
  }
  return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
