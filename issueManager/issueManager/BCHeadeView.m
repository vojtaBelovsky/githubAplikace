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

#define TITLE_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define DUE_IN_FONT         [UIFont fontWithName:@"ProximaNova-Light" size:14]
#define TEXT_COLOR          [UIColor colorWithRed:.39 green:.39 blue:.39 alpha:1.00]

#define TITLE_OFFSET        ( 20.0f )
#define DUE_IN_OFFSET       ( 10.0f )

@implementation BCHeadeView

- (id)initWithFrame:(CGRect)frame andMilestone:(BCMilestone *)milestone
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];

    _title = [[UILabel alloc] init];
    [_title setBackgroundColor:[UIColor clearColor]];
    [_title setFont:TITLE_FONT];
    [_title setTextColor:TEXT_COLOR];
    [_title setTextAlignment:NSTextAlignmentLeft];
    if (milestone) {
      [_title setText:milestone.title];
    }else{
      [_title setText:@"Issues with no milestone"];
    }
    [_title setNumberOfLines:1];
    [self addSubview:_title];
    
    _dueIn = [[UILabel alloc] init];
    [_dueIn setBackgroundColor:[UIColor clearColor]];
    [_dueIn setFont:DUE_IN_FONT];
    [_dueIn setTextColor:TEXT_COLOR];
    [_dueIn setTextAlignment:NSTextAlignmentRight];
    if (milestone.dueOn) {
      [_dueIn setText:[milestone.dueOn stringDifferenceFromNow]];
    }else{
      [_dueIn setText:@"No due date"];
    }
    [_dueIn setNumberOfLines:1];
    [self addSubview:_dueIn];
  }
  return self;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = CGSizeMake((self.frame.size.width-TITLE_OFFSET-DUE_IN_OFFSET)/2, self.frame.size.height);
  frame.origin = CGPointMake(TITLE_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_title.frame, frame)) {
    _title.frame = frame;
  }
  
  frame.size = CGSizeMake((self.frame.size.width-TITLE_OFFSET-DUE_IN_OFFSET)/2, self.frame.size.height);
  frame.origin = CGPointMake(TITLE_OFFSET+_title.frame.size.width, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_dueIn.frame, frame)) {
    _dueIn.frame = frame;
  }
}

@end
