//
//  BCaddIssueButton.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCaddIssueButtonMC.h"
#import "BCLabel.h"
#import "BCAddIssueContentImgView.h"

#define TITLE_FONT_COLOR            [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define COMMENT_FONT_COLOR          [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1.00]
#define CONTENT_FONT_COLOR          [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]
#define CONTENT_FONT_SHADOW_COLOR   [UIColor colorWithRed:.00 green:.47 blue:.64 alpha:1.00]

#define TITLE_FONT            [UIFont fontWithName:@"ProximaNova-Regular" size:14]
#define CONTENT_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:12]

#define TITLE_OFFSET              ( 15.0f )
#define LABELS_OFFSET             ( 5.0f )
#define NEW_PLUS_OFFSET           ( 30.0f )
#define MAXIMUM_MILESTONE_WIDTH   ( 150.0f )
#define TEXT_HEIGHT               ( 15.0f )

#define NEW_ISSUE_PLUS_OFF  [UIImage imageNamed:@"newIssuePlusOff.png"]
#define NEW_ISSUE_PLUS_ON   [UIImage imageNamed:@"newIssuePlusOn.png"]
#define NEW_ISSUE_SEPARATOR [UIImage imageNamed:@"newIssueSeparator.png"]

#define CONTENT_ORIGIN  CGRectMake(

@implementation BCaddIssueButtonMC

- (id)initWithTitle:(NSString *)title{
  self = [super init];
  if (self) {
    _originalHeight = 0;
    _actualHeight = 0;
    _contentImgViews = [[NSMutableArray alloc] init];
    _labels = [[NSMutableArray alloc] init];
    
    _myTitleLabel = [[UILabel alloc] init];
    [_myTitleLabel setText:title];
    [_myTitleLabel setTextColor:TITLE_FONT_COLOR];
    [_myTitleLabel setFont:TITLE_FONT];
    [_myTitleLabel setNumberOfLines:0];
    [self addSubview:_myTitleLabel];
    
    _theNewIssuePlus = [[UIButton alloc] init];
    [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_OFF forState:UIControlStateNormal];
    [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_ON forState:UIControlStateHighlighted];
    [self addSubview:_theNewIssuePlus];
    
    _contentView = [[UIView alloc] init];
    [_contentView setHidden:NO];
    [self addSubview:_contentView];
    
    UIImage *image = [NEW_ISSUE_SEPARATOR stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    _separatorImgView = [[UIImageView alloc] initWithImage:image];
    [_separatorImgView setFrame:CGRectMake(0, _actualHeight-1, self.frame.size.width, 1)];
    [self addSubview:_separatorImgView];
  }
  return self;
}

-(void)setLabels:(NSMutableArray *)labels{
  _labels = labels;
  [self setNeedsLayout];
}

-(CGSize)countMySizeWithWidth:(CGFloat)width{
  CGSize size;
  CGSize titleSize = [_myTitleLabel sizeThatFits:self.frame.size];
  CGSize contentSize = CGSizeMake(width-(3*TITLE_OFFSET)-titleSize.width, self.frame.size.height);
  
  int actualHeight = _originalHeight;
  if ([_labels count] != 0) {
    BCAddIssueContentImgView *contentImgView = [[BCAddIssueContentImgView alloc] init];
    CGPoint origin = CGPointZero;
    for (BCLabel *object in _labels) {
      [contentImgView setMyTextLabelWitText:object.name];
      if ((origin.x+LABELS_OFFSET+contentImgView.frame.size.width) > contentSize.width) {
        actualHeight += _originalHeight;
        origin.x = 0;
      }
      origin.x = (origin.x+contentImgView.frame.size.width+LABELS_OFFSET);
    }
    size = CGSizeMake(width, actualHeight);
  }else{
    size = CGSizeMake(width, _originalHeight);
  }
  return size;
}

#pragma mark - 
#pragma mark private

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = [_myTitleLabel sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(TITLE_OFFSET, (_originalHeight-frame.size.height)/2);
  if (!CGRectEqualToRect(_myTitleLabel.frame, frame)) {
    _myTitleLabel.frame = frame;
  }
  
  frame.size = [_theNewIssuePlus sizeThatFits:self.frame.size];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)-TITLE_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_theNewIssuePlus.frame, frame)) {
    _theNewIssuePlus.frame = frame;
  }
  
  frame.size = CGSizeMake((self.frame.size.width-(3*TITLE_OFFSET)-_myTitleLabel.frame.size
                           .width), self.frame.size.height);
  frame.origin = CGPointMake(((2*TITLE_OFFSET)+_myTitleLabel.frame.size.width), 0);
  if (!CGRectEqualToRect(_contentView.frame, frame)) {
    _contentView.frame = frame;
  }
  
  _actualHeight = _originalHeight;
  for (BCAddIssueContentImgView *object in _contentImgViews) {
    [object removeFromSuperview];
  }
  if ([_labels count] != 0) {
    BCAddIssueContentImgView *contentImgView;
    CGPoint origin = CGPointZero;
    BOOL isSetedY = NO;
    for (BCLabel *object in _labels) {
      contentImgView = [[BCAddIssueContentImgView alloc] init];
      [contentImgView setMyTextLabelWitText:object.name];
      if (!isSetedY) {//potrebuju horizontalne vycentrovat bubliny, ale jen jednou
        origin.y = (_originalHeight-contentImgView.frame.size.height)/2;
        isSetedY = YES;
      }
      if ((origin.x+LABELS_OFFSET+contentImgView.frame.size.width) > _contentView.frame.size.width) {
        _actualHeight = _actualHeight+_originalHeight;
        origin.x = 0;
        origin.y = origin.y+_originalHeight;
      }
      [contentImgView setFrame:CGRectMake(origin.x, origin.y, contentImgView.frame.size.width, contentImgView.frame.size.height)];
      [_contentImgViews addObject:contentImgView];
      [_contentView addSubview:contentImgView];
      origin.x = (origin.x+contentImgView.frame.size.width+LABELS_OFFSET);
    }
    [_contentView setHidden:NO];
    [_theNewIssuePlus setHidden:YES];
  }else{
    [_contentView setHidden:YES];
    [_theNewIssuePlus setHidden:NO];
  }
  
  frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
  if (!CGRectEqualToRect(_separatorImgView.frame, frame)) {
    _separatorImgView.frame = frame;
  }
}

@end
