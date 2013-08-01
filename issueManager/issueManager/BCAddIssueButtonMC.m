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

- (id)initWithSize:(CGSize)size andTitle:(NSString *)title{
  self = [super init];
  if (self) {
    CGRect frame;
    frame = CGRectZero;
    frame.size = size;
    [self setFrame:frame];
    _originalHeight = size.height;
    _actualHeight = size.height;
    _contentImgViews = [[NSMutableArray alloc] init];
    
    _myTitleLabel = [[UILabel alloc] init];
    [_myTitleLabel setText:title];
    [_myTitleLabel setTextColor:TITLE_FONT_COLOR];
    [_myTitleLabel setFont:TITLE_FONT];
    
    frame.size = [_myTitleLabel sizeThatFits:size];
    frame.origin = CGPointMake(TITLE_OFFSET, (size.height-frame.size.height)/2);
    _myTitleLabel.frame = frame;
    [self addSubview:_myTitleLabel];
    
    _theNewIssuePlus = [[UIButton alloc] init];
    [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_OFF forState:UIControlStateNormal];
    [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_ON forState:UIControlStateHighlighted];
    frame.size = [_theNewIssuePlus sizeThatFits:size];
    frame.origin = CGPointMake((size.width-frame.size.width)-TITLE_OFFSET, (size.height-frame.size.height)/2);
    _theNewIssuePlus.frame = frame;
    [self addSubview:_theNewIssuePlus];
    
    frame.size = CGSizeMake((size.width-(3*TITLE_OFFSET)-_myTitleLabel.frame.size
                             .width), size.height);
    frame.origin = CGPointMake(((2*TITLE_OFFSET)+_myTitleLabel.frame.size.width), 0);
    _contentOrigin = frame.origin;
    _contentView = [[UIView alloc] initWithFrame:frame];
    [_contentView setHidden:YES];
    [self addSubview:_contentView];
    
    UIImage *image = [NEW_ISSUE_SEPARATOR stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    _separatorImgView = [[UIImageView alloc] initWithImage:image];
    [self setSeparatorImgViewPosition];
    [self addSubview:_separatorImgView];
  }
  return self;
}

-(void) setContentWithLabels:(NSArray*)labels{
  _actualHeight = _originalHeight;
  for (BCAddIssueContentImgView *object in _contentImgViews) {
    [object removeFromSuperview];
  }
  if ([labels count] != 0) {
    BCAddIssueContentImgView *contentImgView;
    CGPoint origin = CGPointZero;
    BOOL isSetedY = NO;
    for (BCLabel *object in labels) {
      contentImgView = [[BCAddIssueContentImgView alloc] init];
      [contentImgView setContentWithString:object.name];
      if (!isSetedY) {//potrebuju horizontalne vycentrovat bubliny, ale jen jednou
        origin.y = (_originalHeight-contentImgView.frame.size.height)/2;
        isSetedY = YES;
      }
      if ((origin.x+LABELS_OFFSET+contentImgView.frame.size.width) > _contentView.frame.size.width) {
        _actualHeight = _actualHeight+_originalHeight;        
        origin.x = 0;
        origin.y = origin.y+_originalHeight;
        [self setSeparatorImgViewPosition];
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
}

#pragma mark - 
#pragma mark private

-(void)viewWasTapped{
  
}

-(void)setSeparatorImgViewPosition{
  [_separatorImgView setFrame:CGRectMake(0, _actualHeight-1, self.frame.size.width, 1)];
}

@end
