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
#define LABEL_HEIGHT  ( 20.0f )
#define LABEL_WIDTH   ( 50.0f )

@implementation BCProfileIssue

- (id)init
{
  self = [super init];
  if (self) {
    UIImage *image = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    _profileIssueBackgroundImgView = [[UIImageView alloc] initWithImage:image];
    
    _labelViewsArray = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)setWithIssue:(BCIssue*)issue
{
  BCLabelView * myLabelView;
  for (BCLabel *object in issue.labels) {
    myLabelView = [[BCLabelView alloc] initWithLabel:object];
    [self addSubview:myLabelView];
    [_labelViewsArray addObject:myLabelView];
  }
}

-(void)layoutSubviews{
  CGRect frame;
  frame = CGRectMake(0, 0, 200, 80);
  
  if (!CGRectEqualToRect(self.frame, frame)) {
    self.frame = frame;
  }
  
  CGPoint origin = CGPointMake(10, 50);
  for (BCLabelView *object in _labelViewsArray) {
    frame.origin = origin;
    frame.size = object.frame.size;
    if (!CGRectEqualToRect(object.frame, frame)) {
      object.frame = frame;
    }
    origin.x += object.frame.size.width;
  }
  
}

@end
