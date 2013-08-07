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


- (id)initWithText:(NSString*)text
{
  self = [super init];
  if (self) {
    [self setNumberOfLines:0];
    [self setFont:BODY_FONT];
    [self setTextColor:BODY_FONT_COLOR];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setText:text];
  }
  return self;
}

+(CGSize)sizeOfLabelWithText:(NSString*)string {
  CGSize sizeOfBody;
  sizeOfBody = [string sizeWithFont:BODY_FONT];
  int titleLineHeight = sizeOfBody.height;
  int numberOfLines = sizeOfBody.width/TITLE_LINE_WIDTH+1;
  sizeOfBody = CGSizeMake(TITLE_LINE_WIDTH, numberOfLines*titleLineHeight);
  return sizeOfBody;
}

@end
