//
//  BCCommentView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/21/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCCommentView.h"
#import "BCComment.h"
#import "UIImageView+AFNetworking.h"
#import "BCUser.h"
#import "NSDate+Additions.h"
#import "BCAvatarImgView.h"

#define HEADER_HEIGHT ( 15.0f )
#define AVATAR_HEIGHT ( 20.0f )
#define AVATAR_WIDTH  ( 20.0f )

#define USER_LEFT_OFFSET    ( 30.0f )
#define TIME_RIGHT_OFFSET   ( 20.0f )
#define BEAK_WIDTH          ( 10.0f )
#define BODY_TEXT_OFFSET    ( 10.0f )

#define BACKGROUND          [UIImage imageNamed:@"issueCommentBackground.png"]
#define TIME_FONT           [UIFont fontWithName:@"ProximaNova-Light" size:12]
#define USER_FONT           [UIFont fontWithName:@"ProximaNova-Semibold" size:12]
#define HEADER_FONT_COLOR   [UIColor colorWithRed:.67 green:.67 blue:.67 alpha:1.00]
#define BODY_COLOR          [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]
#define BODY_FONT           [UIFont fontWithName:@"ProximaNova-Regular" size:14]
#define PLACEHOLDER_IMG     [UIImage imageNamed:@"gravatar-user-420.png"]

@implementation BCCommentView

- (id)initWithComment:(BCComment *)comment
{
  self = [super init];
  if (self) {    
    UIImage *resizableImage = [BACKGROUND stretchableImageWithLeftCapWidth:15 topCapHeight:30];
    _backgroundImageView = [[UIImageView alloc] initWithImage:resizableImage];
    [self addSubview:_backgroundImageView];
    
    _userName = [[UILabel alloc] init];
    [_userName setText:comment.user.userLogin];
    [_userName setTextColor:HEADER_FONT_COLOR];
    [_userName setFont:USER_FONT];
    [_userName setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_userName];
    
    _commentedBefore = [[UILabel alloc] init];
    [_commentedBefore setText:[comment.updatedAt stringDifferenceFromNowShortStyle]];
    [_commentedBefore setTextColor:HEADER_FONT_COLOR];
    [_commentedBefore setFont:TIME_FONT];
    [_commentedBefore setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_commentedBefore];
    
    _avatar = [[BCAvatarImgView alloc] init];
    [_avatar setImageWithURL:comment.user.avatarUrl placeholderImage:PLACEHOLDER_IMG];
    [self addSubview:_avatar];
    
    _body = [[UILabel alloc] init];
    [_body setTextColor:BODY_COLOR];
    [_body setFont:BODY_FONT];
    [_body setText:comment.body];
    [_body setLineBreakMode:NSLineBreakByWordWrapping];
    [_body setNumberOfLines:0];
    [self addSubview:_body];
  }
  return self;
}

#pragma mark - public

-(CGSize)sizeOfViewWithWidth:(CGFloat)width{
  CGSize size;
  size.width = width;
  size.height = [_body.text sizeWithFont:BODY_FONT constrainedToSize:CGSizeMake(width-AVATAR_WIDTH-BEAK_WIDTH-2*BODY_TEXT_OFFSET, 5000) lineBreakMode:NSLineBreakByWordWrapping].height;
  size.height += 2*BODY_TEXT_OFFSET;
  size.height += HEADER_HEIGHT;
  return size;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame = CGRectZero;
  
  frame.size = [_userName sizeThatFits:CGSizeMake(self.frame.size.width, HEADER_HEIGHT)];
  frame.origin = CGPointMake(USER_LEFT_OFFSET, 0);
  if (!CGRectEqualToRect(_userName.frame, frame)) {
    _userName.frame = frame;
  }
  
  frame.size = [_commentedBefore sizeThatFits:CGSizeMake(self.frame.size.width, HEADER_HEIGHT)];
  frame.origin = CGPointMake(self.frame.size.width-frame.size.width-TIME_RIGHT_OFFSET, 0);
  if (!CGRectEqualToRect(_commentedBefore.frame, frame)) {
    _commentedBefore.frame = frame;
  }
  
  frame = CGRectMake(0, HEADER_HEIGHT, AVATAR_WIDTH, AVATAR_HEIGHT);
  if (!CGRectEqualToRect(_avatar.frame, frame)) {
    _avatar.frame = frame;
  }
  
  frame.size = [_body.text sizeWithFont:BODY_FONT constrainedToSize:CGSizeMake(self.frame.size.width- AVATAR_WIDTH-BEAK_WIDTH-2*BODY_TEXT_OFFSET, 5000) lineBreakMode:NSLineBreakByWordWrapping];
  frame.origin = CGPointMake(AVATAR_WIDTH+BEAK_WIDTH+BODY_TEXT_OFFSET, HEADER_HEIGHT+BODY_TEXT_OFFSET);
  if (!CGRectEqualToRect(_body.frame, frame)) {
    _body.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.width-AVATAR_WIDTH, _body.frame.size.height+2*BODY_TEXT_OFFSET);
  frame.origin = CGPointMake(AVATAR_WIDTH, HEADER_HEIGHT);
  if (!CGRectEqualToRect(_backgroundImageView.frame, frame)) {
    _backgroundImageView.frame = frame;
  }
}

@end
