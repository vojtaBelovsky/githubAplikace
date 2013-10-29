//
//  BCaddIssueButton.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCaddIssueButton.h"
#import "BCMilestone.h"
#import "BCUser.h"
#import "BCAddIssueContentImgView.h"

#define TITLE_FONT_COLOR            [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define COMMENT_FONT_COLOR          [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1.00]
#define CONTENT_FONT_COLOR          [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]
#define CONTENT_FONT_SHADOW_COLOR   [UIColor colorWithRed:.00 green:.47 blue:.64 alpha:1.00]

#define TITLE_FONT            [UIFont fontWithName:@"ProximaNova-Regular" size:14]
#define CONTENT_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:12]

#define TITLE_OFFSET              ( 15.0f )
#define NEW_PLUS_OFFSET           ( 30.0f )
#define MAXIMUM_CONTENT_IMG_WIDTH ( self.frame.size.width-_myTitleLabel.frame.size.width-(3*TITLE_OFFSET) )

#define NEW_ISSUE_PLUS_OFF  [UIImage imageNamed:@"newIssuePlusOff.png"]
#define NEW_ISSUE_PLUS_ON   [UIImage imageNamed:@"newIssuePlusOn.png"]
#define NEW_ISSUE_SEPARATOR [UIImage imageNamed:@"newIssueSeparator.png"]

#define CONTENT_ORIGIN  CGRectMake(

@implementation BCaddIssueButton

- (id)initWithTitle:(NSString *)title{
  self = [super init];
  if (self) {
    _myTitleLabel = [[UILabel alloc] init];
    [_myTitleLabel setText:title];
    [_myTitleLabel setTextColor:TITLE_FONT_COLOR];
    [_myTitleLabel setFont:TITLE_FONT];
    [self addSubview:_myTitleLabel];
    
    _theNewIssuePlus = [[UIButton alloc] init];
    [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_OFF forState:UIControlStateNormal];
    [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_ON forState:UIControlStateHighlighted];
    [self addSubview:_theNewIssuePlus];
    
    _contentImgView = [[BCAddIssueContentImgView alloc] init];
    [self addSubview:_contentImgView];
    
    UIImage *image = [NEW_ISSUE_SEPARATOR stretchableImageWithLeftCapWidth:0 topCapHeight:1];

    _separatorImgView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_separatorImgView];
  }
  return self;
}

-(void) setContentWithText:(NSString*)text{
  if ([text length] != 0) {
    [_contentImgView setMyTextLabelWitText:text];
    [_contentImgView setHidden:NO];
    [_theNewIssuePlus setHidden:YES];
  }else{
    [_contentImgView setHidden:YES];
    [_theNewIssuePlus setHidden:NO];
  }
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = [_myTitleLabel sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(TITLE_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_myTitleLabel.frame, frame)) {
    _myTitleLabel.frame = frame;
  }
  
  frame.size = [_theNewIssuePlus sizeThatFits:self.frame.size];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)-TITLE_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_theNewIssuePlus.frame, frame)) {
    _theNewIssuePlus.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.width, 1);
  frame.origin = CGPointMake(0, self.frame.size.height-1);
  if (!CGRectEqualToRect(_separatorImgView.frame, frame)) {
    _separatorImgView.frame = frame;
  }
  
  frame.size = _contentImgView.frame.size;
  frame.size.width = MIN(frame.size.width, MAXIMUM_CONTENT_IMG_WIDTH);
  frame.origin = CGPointMake(_myTitleLabel.frame.size.width+(2*TITLE_OFFSET), (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_contentImgView.frame, frame)) {
    _contentImgView.frame = frame;
  }
}

@end
