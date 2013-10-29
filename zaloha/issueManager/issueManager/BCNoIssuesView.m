//
//  BCNoIssuesView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCNoIssuesView.h"

#define NO_ISSUE_TEXT             @"There are no issues for"
#define NO_ISSUE_FONT_COLOR       [UIColor colorWithRed:.26 green:.26 blue:.26 alpha:1.00]
#define NO_ISSUE_FONT             [UIFont fontWithName:@"ProximaNova-Semibold" size:18]
#define USER_NAME_FONT_COLOR      [UIColor colorWithRed:.42 green:.42 blue:.42 alpha:1.00]
#define USER_NAME_FONT            [UIFont fontWithName:@"ProximaNovaCond-Semibold" size:18]
#define USER_NAME_OFFSET          ( 10.0f )

@implementation BCNoIssuesView

- (id)init
{
    self = [super init];
    if (self) {
      _noIssues = [[UILabel alloc] init];
      [_noIssues setBackgroundColor:[UIColor clearColor]];
      [_noIssues setTextColor:NO_ISSUE_FONT_COLOR];
      [_noIssues setFont:NO_ISSUE_FONT];
      [_noIssues setText:NO_ISSUE_TEXT];
      [self addSubview:_noIssues];
      
      _userName = [[UILabel alloc] init];
      [_userName setBackgroundColor:[UIColor clearColor]];
      [_userName setTextColor:USER_NAME_FONT_COLOR];
      [_userName setFont:USER_NAME_FONT];
      [self addSubview:_userName];
    }
    return self;
}

-(void)setUserNameWithText:(NSString *)userName{
  [_userName setText:userName];
  [self setNeedsLayout];
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = [_noIssues sizeThatFits:self.frame.size];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_noIssues.frame, frame)) {
    _noIssues.frame = frame;
  }
  
  frame.size = [_userName sizeThatFits:self.frame.size];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, _noIssues.frame.origin.y+_noIssues.frame.size.height+USER_NAME_OFFSET);
  if (!CGRectEqualToRect(_userName.frame, frame)) {
    _userName.frame = frame;
  }
}

@end
