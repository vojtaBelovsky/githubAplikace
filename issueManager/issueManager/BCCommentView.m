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
#define BODY_TEXT_OFFSET    ( 0.0f )
#define COMMENT_OFFSET      ( 5.0f )

#define COMMENT_BUTTON_WIDTH     ( 40.0f )
#define COMMENT_BUTTON_HEIGHT    ( 20.0f )

#define BACKGROUND          [UIImage imageNamed:@"issueCommentBackground.png"]
#define TIME_FONT           [UIFont fontWithName:@"ProximaNova-Light" size:12]
#define USER_FONT           [UIFont fontWithName:@"ProximaNova-Semibold" size:12]
#define HEADER_FONT_COLOR   [UIColor colorWithRed:.67 green:.67 blue:.67 alpha:1.00]
#define PLACEHOLDER_IMG     [UIImage imageNamed:@"gravatar-user-420.png"]
#define COMMENT_MASK        [UIImage imageNamed:@"commentMask.png"]
#define COMMENT_BUTTON      [UIImage imageNamed:@"loginButtonOff.png"]
#define COMMENT_BUTTON_HL   [UIImage imageNamed:@"loginButtonOn.png"]

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
    [[_avatar maskImageView] setImage:COMMENT_MASK];
    [self addSubview:_avatar];
    
    _body = [[UILabel alloc] init];
    [_body setTextColor:COMMENT_BODY_COLOR];
    [_body setFont:COMMENT_BODY_FONT];
    [_body setText:comment.body];
    [_body setLineBreakMode:NSLineBreakByWordWrapping];
    [_body setNumberOfLines:0];
    [self addSubview:_body];
    
    _commentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    [_commentTextView setDelegate:self];
    [_commentTextView setScrollEnabled:NO];
    [_commentTextView setEditable:NO];
    [_commentTextView setBackgroundColor:[UIColor clearColor]];
    [_commentTextView setText:comment.body];
    [_commentTextView setTextColor:COMMENT_BODY_COLOR];
    [_commentTextView setFont:COMMENT_BODY_FONT];
    [self addSubview:_commentTextView];
    
    _commentButton = [[UIButton alloc] init];
    [_commentButton setImage:COMMENT_BUTTON forState:UIControlStateNormal];
    [_commentButton setImage:COMMENT_BUTTON_HL forState:UIControlStateHighlighted];
    [_commentButton setHidden:YES];
    [self addSubview:_commentButton];
  }
  return self;
}

#pragma mark - private

-(int)widthOfCommentTextView{
  return self.frame.size.width-(AVATAR_WIDTH+BEAK_WIDTH+2*BODY_TEXT_OFFSET);
}

-(void)textViewDidChange:(UITextView *)textView{
  int height = textView.frame.size.height;
  height = textView.contentSize.height;
  if (textView.frame.size.height != textView.contentSize.height) {
    _body.text = textView.text;
    CGRect frame = textView.frame;
    frame.size = textView.contentSize;
    [textView setFrame:CGRectZero];
  }
}

#pragma mark - public

-(void)setEnabledForCommenting{
  [_commentTextView setEditable:YES];
  [_commentButton setHidden:NO];
}

-(void)setDisabledForCommenting{
  [_commentTextView setEditable:NO];
  [_commentButton setHidden:YES];
  [self layoutIfNeeded];
}

-(CGSize)sizeOfViewWithWidth:(CGFloat)width{
  CGSize size;
  size.width = width;
  size.height =  [_commentTextView sizeThatFits:CGSizeMake([self widthOfCommentTextView], 5000)].height;
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
  
  frame.size = [_commentTextView sizeThatFits:CGSizeMake([self widthOfCommentTextView], 5000)];
  frame.origin = CGPointMake(AVATAR_WIDTH+BEAK_WIDTH+BODY_TEXT_OFFSET, HEADER_HEIGHT+BODY_TEXT_OFFSET);
  if (!CGRectEqualToRect(_commentTextView.frame, frame)) {
    _commentTextView.frame = frame;
  }

  frame.size = CGSizeMake(self.frame.size.width-AVATAR_WIDTH, _commentTextView.frame.size.height+2*BODY_TEXT_OFFSET);
  frame.origin = CGPointMake(AVATAR_WIDTH, HEADER_HEIGHT);
  if (!CGRectEqualToRect(_backgroundImageView.frame, frame)) {
    _backgroundImageView.frame = frame;
  }
  
//  frame.size = [_body.text sizeWithFont:COMMENT_BODY_FONT constrainedToSize:CGSizeMake([self widthOfCommentTextView], 5000) lineBreakMode:NSLineBreakByWordWrapping];
//  frame.origin = CGPointMake(AVATAR_WIDTH+BEAK_WIDTH+BODY_TEXT_OFFSET, HEADER_HEIGHT+BODY_TEXT_OFFSET);
//  if (!CGRectEqualToRect(_body.frame, frame)) {
//    _body.frame = frame;
//  }
//  
//  frame.size = CGSizeMake([self widthOfCommentTextView], _body.frame.size.height);
////  frame.size = [_commentTextView sizeThatFits:CGSizeMake([self widthOfCommentTextView], 5000)];
//  frame.origin = _body.frame.origin;
//  if (!CGRectEqualToRect(_commentTextView.frame, frame)) {
//    _commentTextView.frame = frame;
//    CGRect bounds = frame;
//    bounds.origin = CGPointZero;
//    [_commentTextView setBounds:bounds];
//  }
//  
//  frame.size = CGSizeMake(self.frame.size.width-AVATAR_WIDTH, _body.frame.size.height+2*BODY_TEXT_OFFSET);
//  frame.origin = CGPointMake(AVATAR_WIDTH, HEADER_HEIGHT);
//  if (!CGRectEqualToRect(_backgroundImageView.frame, frame)) {
//    _backgroundImageView.frame = frame;
//  }
  
  frame.size = CGSizeMake(COMMENT_BUTTON_WIDTH, COMMENT_BUTTON_HEIGHT);
  frame.origin = CGPointMake(self.frame.size.width-COMMENT_BUTTON_WIDTH, _backgroundImageView.frame.origin.y+_backgroundImageView.frame.size.height+COMMENT_OFFSET);
  if (!CGRectEqualToRect(_commentButton.frame, frame)) {
    _commentButton.frame = frame;
  }
}

@end
