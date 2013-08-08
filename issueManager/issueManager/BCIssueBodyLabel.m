//
//  BCIssueBodyLabel.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueBodyLabel.h"

#define BODY_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:16]
#define BODY_FONT_COLOR    [UIColor colorWithRed:.41 green:.41 blue:.41 alpha:1.00]

#define TITLE_LINE_WIDTH    ( 280.0f )

@implementation BCIssueBodyLabel


- (id)init
{
  self = [super init];
  if (self) {
    [self setNumberOfLines:0];
    [self setFont:BODY_FONT];
    [self setTextColor:BODY_FONT_COLOR];
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

-(CGSize)sizeOfLabel{
  return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(TITLE_LINE_WIDTH, 1000000) lineBreakMode:NSLineBreakByWordWrapping];
}

@end
