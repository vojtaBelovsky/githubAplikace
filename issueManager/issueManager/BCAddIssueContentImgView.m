//
//  BCAddIssueContentImgView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCAddIssueContentImgView.h"

#define CONTENT_FONT_COLOR          [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00]
#define CONTENT_FONT_SHADOW_COLOR   [UIColor colorWithRed:.00 green:.47 blue:.64 alpha:1.00]
  
#define CONTENT_FONT                [UIFont fontWithName:@"ProximaNova-Regular" size:13]
#define WIDTH_CONTENT_OFFSET        ( 14.0f )
#define HEIGHT_CONTENT_OFFSET       ( 7.0f )
#define CONTENT_ORIGIN              CGPointMake(WIDTH_CONTENT_OFFSET,HEIGHT_CONTENT_OFFSET)

#define NEW_ISSUE_SELECTED_OBJECT   [UIImage imageNamed:@"newIssueSelectedObject.png"]

#define MAXIMUM_WIDTH   ( 150.0f )

@implementation BCAddIssueContentImgView

- (id)init
{
  self = [super init];
  if (self) {
    _backgroundImgView = [[UIImageView alloc] init];
    [_backgroundImgView setFrame:CGRectZero];
    [self addSubview:_backgroundImgView];
    
    _myTextShadowLabel = [[UILabel alloc] init];
    [_myTextShadowLabel setTextColor:CONTENT_FONT_SHADOW_COLOR];
    [_myTextShadowLabel setFont:CONTENT_FONT];
    [_myTextShadowLabel setFrame:CGRectZero];
    [_myTextShadowLabel setBackgroundColor:[UIColor clearColor]];
    [_backgroundImgView addSubview:_myTextShadowLabel];
    
    _myTextLabel = [[UILabel alloc] init];
    [_myTextLabel setTextColor:[UIColor whiteColor]];
    [_myTextLabel setFont:CONTENT_FONT];
    [_myTextLabel setFrame:CGRectZero];
    [_myTextLabel setBackgroundColor:[UIColor clearColor]];
    [_backgroundImgView addSubview:_myTextLabel];
    
    self.frame = CGRectZero;
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

-(void) setContentWithString:(NSString*)content{
  CGRect frame;
  frame.size = [content sizeWithFont:CONTENT_FONT];
  frame.size.width = MIN(frame.size.width, MAXIMUM_WIDTH);
  frame.origin = CONTENT_ORIGIN;
  
  UIImage *image = [NEW_ISSUE_SELECTED_OBJECT stretchableImageWithLeftCapWidth:20 topCapHeight:0];
  frame.origin = CGPointZero;
  frame.size = CGSizeMake(frame.size.width+(2*WIDTH_CONTENT_OFFSET), frame.size.height+(2*HEIGHT_CONTENT_OFFSET));
  [_backgroundImgView setImage:image];
  [_backgroundImgView setFrame:frame];
  [self addSubview:_backgroundImgView];
  [self setFrame:frame];
  
  [_myTextLabel setText:content];
  frame.size = [content sizeWithFont:CONTENT_FONT];
  frame.size.width = MIN(frame.size.width, MAXIMUM_WIDTH);
  frame.origin = CONTENT_ORIGIN;
  [_myTextLabel setFrame:frame];
  
  [_myTextShadowLabel setText:content];
  frame = CGRectMake(frame.origin.x+1, frame.origin.y+1, frame.size.width, frame.size.height);
  [_myTextShadowLabel setFrame:frame];
}

-(void) setHidden:(BOOL)hidden{
  [_myTextLabel setHidden:hidden];
  [_myTextShadowLabel setHidden:hidden];
  [_backgroundImgView setHidden:hidden];
}

@end
