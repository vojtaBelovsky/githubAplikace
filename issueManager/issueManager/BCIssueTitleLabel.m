//
//  BCIssueTitleLabel.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/5/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueTitleLabel.h"

#define EMPTY_STRING      @"         "
#define LINE_BREAK_MODE   NSLineBreakByWordWrapping

@implementation BCIssueTitleLabel


- (id)initWithFont:(UIFont*)font andColor:(UIColor*)color
{
  self = [super init];
  if (self) {
    [self setNumberOfLines:0];
    [self setFont:font];
    [self setTextColor:color];
    [self setLineBreakMode:LINE_BREAK_MODE];
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

-(void)setText:(NSString *)text{
  text = [[NSString alloc] initWithFormat:@"%@%@",EMPTY_STRING,text];
  [super setText:text];
}

-(CGSize)sizeOfLabelWithWidth:(CGFloat)width{
  return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(width, 2000) lineBreakMode:LINE_BREAK_MODE];
}

+(CGSize)sizeOfLabelWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width{
  text = [[NSString alloc] initWithFormat:@"%@%@",EMPTY_STRING,text];
  CGSize sizeOfTitle;
  sizeOfTitle = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 2000) lineBreakMode:LINE_BREAK_MODE];
//  int titleLineHeight = sizeOfTitle.height;
//  int numberOfLines = sizeOfTitle.width/width+1;
//  sizeOfTitle = CGSizeMake(width, numberOfLines*titleLineHeight);
  return sizeOfTitle;
}

@end
