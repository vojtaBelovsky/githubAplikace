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
#define TITLE_FONT_COLOR              [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]

#define HASH_WIDTH            ( 30.0f )
#define HASH_HEIGHT           _titleLabel.font.pointSize

#define USER_VIEW_HEIGHT      ( 20.0f )

@implementation BCSingleIssueView

- (id)initWithTitleFont:(UIFont *)font showAll:(BOOL)showAll offset:(CGFloat)offset
{
  self = [super init];
  if (self) {
    _offset = offset;
    _showAll = showAll;
    
    UIImage *image = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    _profileIssueBackgroundImgView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_profileIssueBackgroundImgView];
    
    _numberView = [[BCIssueNumberView alloc] init];
    [self addSubview:_numberView];
    
    _titleLabel = [[BCIssueTitleLabel alloc] initWithFont:font andColor:TITLE_FONT_COLOR];
    [self addSubview:_titleLabel];
    
    _bodyLabel = [[BCIssueBodyLabel alloc] init];
    [self addSubview:_bodyLabel];
    
    _userView = [[BCIssueUserView alloc] init];
    [_userView setHidden:YES];
    [self addSubview:_userView];
    
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
    [_userView setHidden:NO];
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

+(CGSize)sizeOfSingleIssueViewWithIssue:(BCIssue *)issue width:(CGFloat)width offset:(CGFloat)offset titleFont:(UIFont *)font showAll:(BOOL)show{
  CGFloat maxContentWidth = width-(2*offset);
  
  CGFloat totalHeight = [BCIssueTitleLabel sizeOfLabelWithText:issue.title font:font width:maxContentWidth].height+(2*offset);
  CGSize sizeOfCurrentLabel;
  int labelsWidth = maxContentWidth+1;
  int heightOfLabels = 0;
  int numberOfOffets = 0;
  for (BCLabel *object in issue.labels) {
    sizeOfCurrentLabel = [BCLabelView sizeOfLabelWithText:object.name];
    if ((labelsWidth+sizeOfCurrentLabel.width)>maxContentWidth) {
      numberOfOffets++;
      heightOfLabels += sizeOfCurrentLabel.height;
      labelsWidth = 0;
    }
    labelsWidth += sizeOfCurrentLabel.width;
  }
  if (numberOfOffets) {
    numberOfOffets--;
  }
  totalHeight += heightOfLabels+(numberOfOffets*OFFSET_BETWEEN_LABELS);
  if (heightOfLabels) {
    totalHeight += TOP_OFFSET_BETWEEN_CONTENT;
  }
  
  if (!show) {
    return CGSizeMake(width, totalHeight);
  }
  
  CGSize bodySize = [BCIssueBodyLabel sizeOfLabelWithText:issue.body width:maxContentWidth];
  if (bodySize.height) {
    totalHeight += bodySize.height+TOP_OFFSET_BETWEEN_CONTENT;
  }
  
  totalHeight += USER_VIEW_HEIGHT+TOP_OFFSET_BETWEEN_CONTENT;
  return CGSizeMake(width, totalHeight);
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame = self.frame;
  CGFloat maxContentWidth = frame.size.width-(2*_offset);
  
  frame.origin = CGPointZero;
  if (!CGRectEqualToRect(_profileIssueBackgroundImgView.frame, frame)) {
    _profileIssueBackgroundImgView.frame = frame;
  }
  
  frame = CGRectMake(_offset, _offset, HASH_WIDTH, HASH_HEIGHT);
  if (!CGRectEqualToRect(_numberView.frame, frame)) {
    _numberView.frame = frame;
  }
  
  frame.size = [_titleLabel sizeOfLabelWithWidth:maxContentWidth];
  frame.origin = CGPointMake(_offset, _offset);
  if (!CGRectEqualToRect(_titleLabel.frame, frame)) {
    _titleLabel.frame = frame;
  }
  
  frame.size = [BCIssueBodyLabel sizeOfLabelWithText:_bodyLabel.text width:maxContentWidth];
  frame.origin = CGPointMake(_offset, _offset+_titleLabel.frame.size.height+TOP_OFFSET_BETWEEN_CONTENT);
  if (!CGRectEqualToRect(_bodyLabel.frame, frame)) {
    _bodyLabel.frame = frame;
  }
  
  if (_bodyLabel.frame.size.height) {
    frame.origin.y += _bodyLabel.frame.size.height+TOP_OFFSET_BETWEEN_CONTENT;
  }
  int heightOfLabel = 0;
  for (BCLabelView *object in _labelViewsArray) {
    if ((frame.origin.x+object.frame.size.width)>maxContentWidth) {
      frame.origin.y += [BCLabelView sizeOfLabelWithText:object.myLabel.text].height+OFFSET_BETWEEN_LABELS;
      frame.origin.x = _offset;
    }
    frame.size = [BCLabelView sizeOfLabelWithText:object.myLabel.text];
    if (!CGRectEqualToRect(object.frame, frame)) {
      object.frame = frame;
    }
    frame.origin.x += frame.size.width+OFFSET_BETWEEN_LABELS;
    if (!heightOfLabel) {
      heightOfLabel = frame.size.height;
    }
  }

  if (heightOfLabel) {
    heightOfLabel += TOP_OFFSET_BETWEEN_CONTENT;
  }
  if (_showAll) {
    frame.size = CGSizeMake(maxContentWidth, USER_VIEW_HEIGHT);
    frame.origin = CGPointMake(_offset, frame.origin.y+heightOfLabel);
    if (!CGRectEqualToRect(_userView.frame, frame)) {
      _userView.frame = frame;
    }
  }
}

@end
