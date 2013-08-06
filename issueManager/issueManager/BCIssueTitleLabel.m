//
//  BCIssueTitleLabel.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/5/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueTitleLabel.h"

#define TITLE_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:16]

#define TITLE_LINE_WIDTH    ( 280.0f )
#define TITLE_LINE_HEIGHT   ( 20.0f )

@implementation BCIssueTitleLabel


- (id)init
{
  self = [super init];
  if (self) {
    [self setNumberOfLines:0];
    [self setFont:TITLE_FONT];
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

-(void)setText:(NSString *)text{
  text = [[NSString alloc] initWithFormat:@"         %@",text];
  [super setText:text];
}

+(CGSize)countSizeFromString:(NSString*)string {
  string = [[NSString alloc] initWithFormat:@"         %@",string];
  CGSize sizeOfIssue;
  sizeOfIssue = [string sizeWithFont:TITLE_FONT];
  int numberOfLines = sizeOfIssue.width/TITLE_LINE_WIDTH+1;
  sizeOfIssue = CGSizeMake(TITLE_LINE_WIDTH, numberOfLines*TITLE_LINE_HEIGHT);
  return sizeOfIssue;
}

@end
