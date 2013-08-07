//
//  BCIssueTitleLabel.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/5/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueTitleLabel.h"

#define TITLE_LINE_WIDTH    ( 280.0f )

@implementation BCIssueTitleLabel


- (id)initWithFont:(UIFont*)font andColor:(UIColor*)color
{
  self = [super init];
  if (self) {
    [self setNumberOfLines:0];
    [self setFont:font];
    [self setTextColor:color];
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

-(void)setText:(NSString *)text{
  text = [[NSString alloc] initWithFormat:@"         %@",text];
  [super setText:text];
}

+(CGSize)sizeOfLabelWithText:(NSString*)string withFont:(UIFont*)font{
  string = [[NSString alloc] initWithFormat:@"         %@",string];
  CGSize sizeOfIssue;
  sizeOfIssue = [string sizeWithFont:font];
  int titleLineHeight = sizeOfIssue.height;
  int numberOfLines = sizeOfIssue.width/TITLE_LINE_WIDTH+1;
  sizeOfIssue = CGSizeMake(TITLE_LINE_WIDTH, numberOfLines*titleLineHeight);
  return sizeOfIssue;
}

@end
