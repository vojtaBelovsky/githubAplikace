//
//  BCAddIssueContentImgView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCAddIssueContentImgView.h"
#import <QuartzCore/QuartzCore.h>

#define CONTENT_FONT_COLOR          [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00]
#define CONTENT_FONT_SHADOW_COLOR   [UIColor colorWithRed:.00 green:.47 blue:.64 alpha:1.00]
  
#define CONTENT_FONT                [UIFont fontWithName:@"ProximaNova-Regular" size:13]
#define WIDTH_CONTENT_OFFSET        ( 14.0f )
#define HEIGHT_CONTENT_OFFSET       ( 7.0f )
#define CONTENT_ORIGIN              CGPointMake(WIDTH_CONTENT_OFFSET,HEIGHT_CONTENT_OFFSET)

#define NEW_ISSUE_SELECTED_OBJECT   [UIImage imageNamed:@"newIssueSelectedObject.png"]

@implementation BCAddIssueContentImgView

- (id)init
{
  self = [super init];
  if (self) {
    [self setAlpha:0.85];
    _backgroundImgView = [[UIImageView alloc] init];
    [_backgroundImgView setFrame:CGRectZero];
    UIImage *image = [NEW_ISSUE_SELECTED_OBJECT stretchableImageWithLeftCapWidth:11 topCapHeight:11];
    [_backgroundImgView setImage:image];
    [self addSubview:_backgroundImgView];
    
    _myTextLabel = [[UILabel alloc] init];
    [_myTextLabel setTextColor:[UIColor whiteColor]];
    [_myTextLabel setFont:CONTENT_FONT];
    [_myTextLabel setFrame:CGRectZero];
    [_myTextLabel setBackgroundColor:[UIColor clearColor]];
    _myTextLabel.layer.shadowOpacity = 1.0;
    _myTextLabel.layer.shadowRadius = 0.0;
    _myTextLabel.layer.shadowColor = CONTENT_FONT_SHADOW_COLOR.CGColor;
    _myTextLabel.layer.shadowOffset = CGSizeMake(0.7, 0.7);
    [self addSubview:_myTextLabel];
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

-(void)setMyTextLabelWitText:(NSString *)text{
  [_myTextLabel setText:text];
  CGSize size = [_myTextLabel.text sizeWithFont:CONTENT_FONT];
  size = CGSizeMake(size.width+(2*WIDTH_CONTENT_OFFSET), size.height+(2*HEIGHT_CONTENT_OFFSET));
  [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height)];
}

-(void) setHidden:(BOOL)hidden{
  [super setHidden:hidden];
  [_myTextLabel setHidden:hidden];
  [_backgroundImgView setHidden:hidden];
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame = self.frame;
  
  frame.origin = CGPointZero;
  if (!CGRectEqualToRect(_backgroundImgView.frame, frame)) {
    _backgroundImgView.frame = frame;
  }
  
  frame.size = [_myTextLabel.text sizeWithFont:CONTENT_FONT];
  frame.size.width = MIN(frame.size.width, self.frame.size.width-(2*WIDTH_CONTENT_OFFSET));
  frame.origin = CONTENT_ORIGIN;
  if (!CGRectEqualToRect(_myTextLabel.frame, frame)) {
    _myTextLabel.frame = frame;
  }
}

@end
