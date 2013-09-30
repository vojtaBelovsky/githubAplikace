//
//  BCHeadeView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/7/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCHeadeView.h"
#import "NSDate+Additions.h"
#import "BCMilestone.h"
#import "BCIssueDataSource.h"

#define TITLE_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:14]
#define DUE_IN_FONT         [UIFont fontWithName:@"ProximaNova-Light" size:9]
#define TEXT_COLOR_GRAY     [UIColor colorWithRed:.39 green:.39 blue:.39 alpha:1.00]
#define TEXT_COLOR_RED      [UIColor colorWithRed:1.39 green:.39 blue:.39 alpha:1.00]
#define BACKGROUND          [UIImage imageNamed:@"headerBackground.png"]

#define TITLE_OFFSET        ( 20.0f )
#define DUE_IN_OFFSET       ( 10.0f )
#define BOTTOM_OFFSET       ( 5.0f )

@implementation BCHeadeView

- (id)initWithFrame:(CGRect)frame andMilestone:(BCMilestone *)milestone
{
  self = [super initWithFrame:frame];
  if (self) {
    UIImage *resizableImage = [BACKGROUND stretchableImageWithLeftCapWidth:1 topCapHeight:10];
    _backgroundImageView = [[UIImageView alloc] initWithImage:resizableImage];
    [self addSubview:_backgroundImageView];
  
    _title = [[UILabel alloc] init];
    [_title setBackgroundColor:[UIColor clearColor]];
    [_title setFont:TITLE_FONT];
    [_title setTextColor:TEXT_COLOR_GRAY];
    [_title setTextAlignment:NSTextAlignmentLeft];
    if (milestone) {
      [_title setText:milestone.title];
    }else{
      [_title setText:WITHOUT_MILESTONE];
    }
    [_title setNumberOfLines:1];
    [self addSubview:_title];
    
    _dueIn = [[UILabel alloc] init];
    [_dueIn setBackgroundColor:[UIColor clearColor]];
    [_dueIn setFont:DUE_IN_FONT];
    [_dueIn setTextAlignment:NSTextAlignmentRight];
    if (milestone.dueOn) {
      [_dueIn setText:[milestone.dueOn stringDifferenceFromNow]];
      if ([_dueIn.text characterAtIndex:0] == '-') {
        [_dueIn setTextColor:TEXT_COLOR_RED];
      }else{
        [_dueIn setTextColor:TEXT_COLOR_GRAY];
      }
    }
    [_dueIn setNumberOfLines:1];
    [self addSubview:_dueIn];
  }
  return self;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = CGSizeMake((self.frame.size.width-TITLE_OFFSET-DUE_IN_OFFSET)*0.80, [_title sizeThatFits:self.frame.size].height);
  frame.origin = CGPointMake(TITLE_OFFSET, self.frame.size.height-BOTTOM_OFFSET-frame.size.height);
  if (!CGRectEqualToRect(_title.frame, frame)) {
    _title.frame = frame;
  }
  
  frame.size = CGSizeMake((self.frame.size.width-TITLE_OFFSET-DUE_IN_OFFSET)*0.20, [_dueIn sizeThatFits:self.frame.size].height);
  frame.origin = CGPointMake(TITLE_OFFSET+_title.frame.size.width, _title.frame.origin.y+_title.frame.size.height-frame.size.height);
  if (!CGRectEqualToRect(_dueIn.frame, frame)) {
    _dueIn.frame = frame;
  }
  
  frame = self.frame;
  frame.origin = CGPointZero;
  if (!CGRectEqualToRect(_backgroundImageView.frame, frame)) {
    _backgroundImageView.frame = frame;
  }
}

@end
