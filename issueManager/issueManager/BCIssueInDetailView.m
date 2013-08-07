//
//  BCIssueInDetailView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueInDetailView.h"
#import "BCLabelView.h"
#import "BCLabel.h"
#import "BCIssue.h"
#import "BCIssueTitleLabel.h"
#import "BCIssueNumberView.h"
#import "BCIssueBodyLabel.h"

#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]

#define TITLE_FONT          [UIFont fontWithName:@"ProximaNova-Semibold" size:16]
#define TITLE_FONT_COLOR    [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]

#define LABELS_OFFSET         ( 4.0f )
#define HASH_WIDTH            ( 30.0f )
#define HASH_HEIGHT           ( 19.0f )
#define TOP_OFFSET            ( 11.0f )
#define LEFT_OFFSET           ( 11.0f )
#define LABELS_TOP_OFFSET     ( 6.0f )
#define PROFILE_ISSUE_WIDTH   ( 300.0f )

@implementation BCIssueInDetailView

- (id)initWithIssue:(BCIssue*)issue
{
  self = [super init];
  if (self) {
    UIImage *image = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    _profileIssueBackgroundImgView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_profileIssueBackgroundImgView];
    
    _issueNumberView = [[BCIssueNumberView alloc] init];
    [_issueNumberView.hashNumber setText:[NSString stringWithFormat:@"%@",issue.number]];
    [self addSubview:_issueNumberView];
    
    _issueTitleLabel = [[BCIssueTitleLabel alloc] initWithFont:TITLE_FONT andColor:TITLE_FONT_COLOR];
    [_issueTitleLabel setText:issue.title];
    [self addSubview:_issueTitleLabel];
    
    _issueBodyLabel = [[BCIssueBodyLabel alloc] initWithText:issue.body];
    [self addSubview:_issueBodyLabel];
    
    _labelViewsArray = [[NSMutableArray alloc] init];
    
    BCLabelView * myLabelView;
    for (BCLabel *object in issue.labels) {
      myLabelView = [[BCLabelView alloc] initWithLabel:object];
      [self addSubview:myLabelView];
      [_labelViewsArray addObject:myLabelView];
    }
  }
  return self;
}

//- (void)setWithIssue:(BCIssue*)issue
//{
//  _issue = issue;
//  [_issueNumberView.hashNumber setText:[NSString stringWithFormat:@"%@",issue.number]];
//  
//  [_issueTitleLabel setText:issue.title];
//  
//  for (BCLabelView *object in _labelViewsArray) {
//    [object removeFromSuperview];
//  }
//  [_labelViewsArray removeAllObjects];
//  BCLabelView * myLabelView;
//  for (BCLabel *object in issue.labels) {
//    myLabelView = [[BCLabelView alloc] initWithLabel:object];
//    [self addSubview:myLabelView];
//    [_labelViewsArray addObject:myLabelView];
//  }
//}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame = self.frame;
  frame.origin = CGPointZero;
  
  if (!CGRectEqualToRect(_profileIssueBackgroundImgView.frame, frame)) {
    _profileIssueBackgroundImgView.frame = frame;
  }
  
  frame = CGRectMake(LEFT_OFFSET, TOP_OFFSET, HASH_WIDTH, HASH_HEIGHT);
  if (!CGRectEqualToRect(_issueNumberView.frame, frame)) {
    _issueNumberView.frame = frame;
  }
  
  frame.size = [BCIssueTitleLabel sizeOfLabelWithText:_issueTitleLabel.text withFont:TITLE_FONT];
  frame.origin = CGPointMake(LEFT_OFFSET, TOP_OFFSET);
  if (!CGRectEqualToRect(_issueTitleLabel.frame, frame)) {
    _issueTitleLabel.frame = frame;
  }
  
  frame.size = [BCIssueBodyLabel sizeOfLabelWithText:_issueBodyLabel.text];
  frame.origin = CGPointMake(LEFT_OFFSET, TOP_OFFSET+_issueTitleLabel.frame.size.height+LABELS_TOP_OFFSET);
  if (!CGRectEqualToRect(_issueBodyLabel.frame, frame)) {
    _issueBodyLabel.frame = frame;
  }
  
  CGPoint origin = CGPointMake(LEFT_OFFSET, 2*LABELS_TOP_OFFSET+TOP_OFFSET+_issueTitleLabel.frame.size.height+_issueBodyLabel.frame.size.height);
  for (BCLabelView *object in _labelViewsArray) {
    if ((origin.x+object.frame.size.width)>(PROFILE_ISSUE_WIDTH-(2*LEFT_OFFSET))) {
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

