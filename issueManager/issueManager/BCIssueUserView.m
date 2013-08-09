//
//  BCIssueUserView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/8/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueUserView.h"
#import "BCIssue.h"
#import "BCUser.h"
#import "BCAvatarImgView.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+Additions.h"

#define AVATAR_OFFSET       ( 10.0f )
#define USER_OFFSET         ( 20.0f )

#define PLACEHOLDER_IMG     [UIImage imageNamed:@"gravatar-user-420.png"]
#define COMMON_COLOR        [UIColor colorWithRed:.67 green:.67 blue:.67 alpha:1.00]
#define USER_NAME_FONT      [UIFont fontWithName:@"ProximaNova-Semibold" size:16]
#define CREATED_FONT        [UIFont fontWithName:@"ProximaNova-Light" size:16]

@implementation BCIssueUserView

- (id)init
{
  self = [super init];
    if (self) {
      _avatarImgView = [[BCAvatarImgView alloc] init];
      [self addSubview:_avatarImgView];
      
      _userName = [[UILabel alloc] init];
      [_userName setTextColor:COMMON_COLOR];
      [_userName setFont:USER_NAME_FONT];
      [_userName setNumberOfLines:0];
      [self addSubview:_userName];
      
      _updated = [[UILabel alloc] init];
      [_updated setTextColor:COMMON_COLOR];
      [_updated setFont:CREATED_FONT];
      [_updated setNumberOfLines:0];
      [_updated setTextAlignment:NSTextAlignmentRight];
      [self addSubview:_updated];
    }
    return self;
}

-(void)setWithIssue:(BCIssue *)issue{
  [_avatarImgView setImageWithURL:issue.user.avatarUrl placeholderImage:PLACEHOLDER_IMG];
  [_userName setText:issue.user.userLogin];
  [_updated setText:[issue.updatedAt stringDifferenceFromNowDetailStyle]];
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame = CGRectZero;
  
  frame.size.width = self.frame.size.height;
  frame.size.height = self.frame.size.height;
  frame.origin = CGPointZero;
  if (!CGRectEqualToRect(_avatarImgView.frame, frame)) {
    _avatarImgView.frame = frame;
  }
  
  frame.size = [_userName sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(_avatarImgView.frame.size.width+USER_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_userName.frame, frame)) {
    _userName.frame = frame;
  }
  
  frame.size = [_updated sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(_avatarImgView.frame.size.width+USER_OFFSET+_userName.frame.size.width, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_updated.frame, frame)) {
    _updated.frame = frame;
  }
}

@end
