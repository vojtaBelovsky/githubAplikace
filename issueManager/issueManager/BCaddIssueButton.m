//
//  BCaddIssueButton.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCaddIssueButton.h"
#import "BCMilestone.h"

#define TITLE_FONT_COLOR      [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define COMMENT_FONT_COLOR    [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1.00]
#define CONTENT_FONT_COLOR    [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]
#define TITLE_FONT            [UIFont fontWithName:@"ProximaNova-Regular" size:14]

#define TITLE_OFFSET              ( 15.0f )
#define NEW_PLUS_OFFSET           ( 30.0f )
#define MAXIMUM_MILESTONE_WIDTH   ( 150.0f )
#define TEXT_HEIGHT               ( 15.0f )

#define NEW_ISSUE_PLUS_OFF  [UIImage imageNamed:@"newIssuePlusOff.png"]
#define NEW_ISSUE_PLUS_ON   [UIImage imageNamed:@"newIssuePlusOn.png"]
#define NEW_ISSUE_SEPARATOR [UIImage imageNamed:@"newIssueSeparator.png"]

@implementation BCaddIssueButton

- (id)initWithSize:(CGSize)size andTitle:(NSString *)title{
  self = [super init];
  if (self) {
    _showPlus = YES;
    
    _myTitleLabel = [[UILabel alloc] init];
    [_myTitleLabel setText:title];
    [_myTitleLabel setTextColor:TITLE_FONT_COLOR];
    [_myTitleLabel setFont:TITLE_FONT];
    CGRect frame;
    frame.size = [_myTitleLabel sizeThatFits:size];
    frame.origin = CGPointMake(TITLE_OFFSET, (size.height-frame.size.height)/2);
    _myTitleLabel.frame = frame;
    [self addSubview:_myTitleLabel];
    
    _milestoneLabel = [[UILabel alloc] init];
    [_milestoneLabel setNumberOfLines:1];
    _milestoneLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_milestoneLabel setTextColor:CONTENT_FONT_COLOR];
    [_milestoneLabel setFont:TITLE_FONT];
    [_milestoneLabel setTextAlignment:NSTextAlignmentCenter];
    frame.size = CGSizeMake(MAXIMUM_MILESTONE_WIDTH, TEXT_HEIGHT);
    frame.origin = CGPointMake((_myTitleLabel.frame.size.width+(2*TITLE_OFFSET)), (size.height-frame.size.height)/2);
    _milestoneLabel.frame = frame;
    _rectOfMilestoneLabelWithPlus = frame;
    _rectOfMilestoneLabelWithoutPlus = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width+(NEW_PLUS_OFFSET), frame.size.height);
    [_milestoneLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_milestoneLabel];
    
    _theNewIssuePlus = [[UIButton alloc] init];
    [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_OFF forState:UIControlStateNormal];
    [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_ON forState:UIControlStateHighlighted];
    frame.size = [_theNewIssuePlus sizeThatFits:size];
    frame.origin = CGPointMake((size.width-frame.size.width)-TITLE_OFFSET, (size.height-frame.size.height)/2);
    _theNewIssuePlus.frame = frame;
    _rectOfNewIssuePlus = frame;
    [self addSubview:_theNewIssuePlus];
    
    UIImage *image = [NEW_ISSUE_SEPARATOR stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    frame.size = CGSizeMake(size.width, 1);
    frame.origin = CGPointMake(0, size.height-1);
    _separatorImgView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_separatorImgView];
  }
  return self;
}

-(void) setMilestoneLabelWithMilestone:(BCMilestone *)milestone{
  if ([milestone.title length] != 0) {
    [_theNewIssuePlus setFrame:CGRectZero];
    [_milestoneLabel setFrame:_rectOfMilestoneLabelWithoutPlus];
  }else{
    [_theNewIssuePlus setFrame:_rectOfNewIssuePlus];
    [_milestoneLabel setFrame:_rectOfMilestoneLabelWithPlus];
  }
  [_milestoneLabel setText:milestone.title];
}

@end
