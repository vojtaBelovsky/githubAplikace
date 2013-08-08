//
//  BCProfileIssue.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/2/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSingleIssueView.h"
#import "BCLabelView.h"
#import "BCLabel.h"
#import "BCIssue.h"
#import "BCIssueTitleLabel.h"
#import "BCIssueNumberView.h"
#import "BCIssueBodyLabel.h"
#import "BCIssueUserView.h"

#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]

#define TITLE_FONT_COLOR    [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]

#define LABELS_OFFSET         ( 4.0f )
#define HASH_WIDTH            ( 30.0f )
#define HASH_HEIGHT           ( 19.0f )
#define TOP_OFFSET            ( 11.0f )
#define LEFT_OFFSET           ( 11.0f )
#define LABELS_TOP_OFFSET     ( 6.0f )

@implementation BCSingleIssueView

- (id)initWithTitleFont:(UIFont *)font showAll:(BOOL)showAll
{
  self = [super init];
  if (self) {
    _showAll = showAll;
    
    UIImage *image = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    _profileIssueBackgroundImgView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_profileIssueBackgroundImgView];
    
    _numberView = [[BCIssueNumberView alloc] init];
    [self addSubview:_numberView];
    
    _titleLabel = [[BCIssueTitleLabel alloc] initWithFont:font andColor:TITLE_FONT_COLOR];
    [self addSubview:_titleLabel];
    
    _bodyLabel = [[BCIssueBodyLabel alloc] init];
    
    _userView = [[BCIssueUserView alloc] init];
    
    _labelViewsArray = [[NSMutableArray alloc] init];
    _issue = nil;
  }
  return self;
}

- (void)setWithIssue:(BCIssue*)issue
{
  if (_showAll) {
    [_bodyLabel setText:issue.body];
    [_userView setWithIssue:issue];
  }
  _issue = issue;
  [_numberView.hashNumber setText:[NSString stringWithFormat:@"%@",issue.number]];
  
  [_titleLabel setText:issue.title];
  
  for (BCLabelView *object in _labelViewsArray) {
    [object removeFromSuperview];
  }
  [_labelViewsArray removeAllObjects];
  BCLabelView * myLabelView;
  for (BCLabel *object in issue.labels) {
    myLabelView = [[BCLabelView alloc] initWithLabel:object];
    [self addSubview:myLabelView];
    [_labelViewsArray addObject:myLabelView];
  }
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame = self.frame;
  frame.origin = CGPointZero;
  
  if (!CGRectEqualToRect(_profileIssueBackgroundImgView.frame, frame)) {
    _profileIssueBackgroundImgView.frame = frame;
  }
  
  frame = CGRectMake(LEFT_OFFSET, TOP_OFFSET, HASH_WIDTH, HASH_HEIGHT);
  if (!CGRectEqualToRect(_numberView.frame, frame)) {
    _numberView.frame = frame;
  }
  
  frame.size = [BCIssueTitleLabel sizeOfLabelWithText:_titleLabel.text withFont:[self.titleLabel font]];
  frame.origin = CGPointMake(LEFT_OFFSET, TOP_OFFSET);
  if (!CGRectEqualToRect(_titleLabel.frame, frame)) {
    _titleLabel.frame = frame;
  }
  
  CGPoint origin = CGPointMake(LEFT_OFFSET, LABELS_TOP_OFFSET+TOP_OFFSET+_titleLabel.frame.size.height);
  for (BCLabelView *object in _labelViewsArray) {
    if ((origin.x+object.frame.size.width)>(self.frame.size.width-(2*LEFT_OFFSET))) {
      origin.y += object.frame.size.height+LABELS_OFFSET;
      origin.x = LEFT_OFFSET;
    }
    frame.origin = origin;
    frame.size = object.frame.size;
    if (!CGRectEqualToRect(object.frame, frame)) {
      object.frame = frame;
    }
    origin.x += object.frame.size.width+LABELS_OFFSET;
  }
  
  
  
}

@end
