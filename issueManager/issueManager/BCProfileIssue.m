//
//  BCProfileIssue.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/2/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCProfileIssue.h"
#import "BCIssueNumberView.h"
#import "BCLabelView.h"
#import "BCLabel.h"
#import "BCIssue.h"

#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]

#define LABELS_OFFSET       ( 4.0f )
#define HASH_WIDTH          ( 30.0f )
#define HASH_HEIGHT         ( 18.0f )
#define HASH_TOP_OFFSET     ( 10.0f )
#define HASH_LEFT_OFFSET    ( 10.0f )

@implementation BCProfileIssue

- (id)init
{
  self = [super init];
  if (self) {
    UIImage *image = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    _profileIssueBackgroundImgView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_profileIssueBackgroundImgView];
    
    _issueNumberView = [[BCIssueNumberView alloc] init];
    [self addSubview:_issueNumberView];
    
    _labelViewsArray = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)setWithIssue:(BCIssue*)issue
{
  [_issueNumberView.hashNumber setText:[NSString stringWithFormat:@"%@11",issue.number]];
  [_issueNumberView.hashNumber layoutIfNeeded];
  
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
  CGRect frame;
  frame = CGRectMake(0, 0, 300, 80);
  
  if (!CGRectEqualToRect(_profileIssueBackgroundImgView.frame, frame)) {
    _profileIssueBackgroundImgView.frame = frame;
  }
  
  frame = CGRectMake(HASH_LEFT_OFFSET, HASH_TOP_OFFSET, HASH_WIDTH, HASH_HEIGHT);
  if (!CGRectEqualToRect(_issueNumberView.frame, frame)) {
    _issueNumberView.frame = frame;
  }
  
  CGPoint origin = CGPointMake(10, 50);
  for (BCLabelView *object in _labelViewsArray) {
    frame.origin = origin;
    frame.size = object.frame.size;
    if (!CGRectEqualToRect(object.frame, frame)) {
      object.frame = frame;
    }
    origin.x += object.frame.size.width+LABELS_OFFSET;
  }
  
}

@end
