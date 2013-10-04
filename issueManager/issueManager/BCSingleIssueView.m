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
#import "BCIssueCell.h"

#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]

#define HASH_WIDTH            ( 20.0f )
#define HASH_HEIGHT           _titleLabel.font.pointSize

#define USER_VIEW_HEIGHT      ( 14.0f )
#define MAGIC_CONSTANT        ( 1.2f )
#define SIDE_OFFSET_BETWEEN_CONTENT   ( 5.0f )

@implementation BCSingleIssueView

#pragma mark -
#pragma mark lifecycles

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
    
    _titleLabel = [[BCIssueTitleLabel alloc] initWithFont:font];
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

#pragma mark -
#pragma mark public

- (void)setIssue:(BCIssue*)issue
{
  _issue = issue;
  _numberView.issueNumber = issue.number;
  if (_showAll) {
    [_bodyLabel setText:issue.body];
    [_userView setWithIssue:issue];
    [_userView setHidden:NO];
  }
  [_numberView.hashNumber setText:[NSString stringWithFormat:@"%@",issue.number]];
  [_numberView setNeedsLayout];
  
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


+(CGSize)sizeOfSingleIssueViewWithIssue:(BCIssue *)issue width:(CGFloat)width offset:(CGFloat)offset titleFont:(UIFont *)font showAll:(BOOL)showAll{
  
  BCSingleIssueView *myIssueView = [[BCSingleIssueView alloc] initWithTitleFont:font showAll:showAll offset:offset];
  [myIssueView setIssue:issue];
  CGRect myRect = CGRectMake(0, 0, width, 0);
  [myIssueView setFrame:myRect];
  [myIssueView layoutSubviews];
  
  if (showAll) {
    myRect.size.height = myIssueView.userView.frame.origin.y+myIssueView.userView.frame.size.height+offset;
    return myRect.size;
  }else{
    BCLabelView *myLabelView =  (BCLabelView*)[myIssueView.labelViewsArray lastObject];
    if (myLabelView != nil) {
      myRect.size.height = myLabelView.frame.origin.y+myLabelView.frame.size.height+offset;
    }else{
      myRect.size.height = myIssueView.titleLabel.frame.origin.y+myIssueView.titleLabel.frame.size.height+offset;
    }
    return myRect.size;
  }
}

#pragma mark -
#pragma mark layoutSubviews

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame = self.frame;
  CGFloat maxContentWidth = frame.size.width-(2*_offset);
  
  frame.origin = CGPointZero;
  if (!CGRectEqualToRect(_profileIssueBackgroundImgView.frame, frame)) {
    _profileIssueBackgroundImgView.frame = frame;
  }
  
  frame.origin = CGPointMake(_offset, _offset);
  frame.size = [_numberView countMySize];
  if (!CGRectEqualToRect(_numberView.frame, frame)) {
    _numberView.frame = frame;
  }
  
  frame.size = [_titleLabel sizeOfLabelWithWidth:maxContentWidth];
  frame.size.height *= MAGIC_CONSTANT;
  frame.origin = CGPointMake(_offset, _offset+HASH_VERTICAL_OFFSET);
  if (!CGRectEqualToRect(_titleLabel.frame, frame)) {
    _titleLabel.frame = frame;
  }
  
  if (_showAll) {
    frame.size = [BCIssueBodyLabel sizeOfLabelWithText:_bodyLabel.text width:maxContentWidth];
    frame.origin = CGPointMake(_offset, _offset+_titleLabel.frame.size.height+TOP_OFFSET_BETWEEN_CONTENT);
    if (!CGRectEqualToRect(_bodyLabel.frame, frame)) {
      _bodyLabel.frame = frame;
    }
    frame.origin.y += _bodyLabel.frame.size.height+TOP_OFFSET_BETWEEN_CONTENT;
  }else{
    int numLines = (int)(_titleLabel.frame.size.height/LINE_HEIGHT);
    frame.origin.y += (numLines-1)*LINE_HEIGHT;
    frame.origin.x += [[_titleLabel getLastLineOfStringInLabel] sizeWithFont:CELL_TITLE_FONT].width+SIDE_OFFSET_BETWEEN_CONTENT;
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
