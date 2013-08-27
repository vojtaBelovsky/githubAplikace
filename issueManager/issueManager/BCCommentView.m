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

#define BACKGROUND          [UIImage imageNamed:@"issueCommentBackground.png"]
#define TIME_FONT           [UIFont fontWithName:@"ProximaNova-Light" size:12]
#define USER_FONT           [UIFont fontWithName:@"ProximaNova-Semibold" size:12]
#define HEADER_FONT_COLOR   [UIColor colorWithRed:.67 green:.67 blue:.67 alpha:1.00]
#define PLACEHOLDER_IMG     [UIImage imageNamed:@"gravatar-user-420.png"]
#define COMMENT_MASK        [UIImage imageNamed:@"commentMask.png"]
#define COMMENT_BUTTON      [UIImage imageNamed:@"loginButtonOff.png"]
#define COMMENT_BUTTON_HL   [UIImage imageNamed:@"loginButtonOn.png"]
#define BUTTON_FONT         [UIFont fontWithName:@"ProximaNova-Regular" size:14]

#define WIDTH_OF_COMMENT_TEXT_VIEW_WITH_WIDTH(width) width-(AVATAR_WIDTH+BEAK_WIDTH)

@implementation BCCommentView

- (id)initWithComment:(BCComment *)comment
{
  self = [super init];
  if (self) {
    UIImage *resizableImage = [BACKGROUND stretchableImageWithLeftCapWidth:15 topCapHeight:30];
    _backgroundImageView = [[UIImageView alloc] initWithImage:resizableImage];
    [self addSubview:_backgroundImageView];
    _lastContentHeight = 0;
    
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
    
    _commentTextView = [[UITextView alloc] init];
    [_commentTextView setScrollEnabled:NO];
    [_commentTextView setEditable:NO];
    [_commentTextView setDelegate:self];
    [_commentTextView setBackgroundColor:[UIColor clearColor]];
    [_commentTextView setText:comment.body];
    [_commentTextView setTextColor:COMMENT_BODY_COLOR];
    [_commentTextView setFont:COMMENT_BODY_FONT];
    [self addSubview:_commentTextView];
    
    resizableImage = [COMMENT_BUTTON stretchableImageWithLeftCapWidth:18 topCapHeight:18];
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setBackgroundImage:resizableImage forState:UIControlStateNormal];
    resizableImage = [COMMENT_BUTTON_HL stretchableImageWithLeftCapWidth:18 topCapHeight:18];
    [_commentButton setBackgroundImage:resizableImage forState:UIControlStateHighlighted];
    [_commentButton setTitle:NSLocalizedString(@"Comment", @"") forState:UIControlStateNormal];
    _commentButton.titleLabel.font = BUTTON_FONT;
    [_commentButton setEnabled:YES];
    [_commentButton setHidden:YES];
    [self addSubview:_commentButton];
  }
  return self;
}

#pragma mark - private

-(void)textViewDidChange:(UITextView *)textView{
  if (textView.contentSize.height != _lastContentHeight) {
    _lastContentHeight = textView.frame.size.height;
    [self setNeedsLayout];
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
  size.height = [_commentTextView sizeThatFits:CGSizeMake(WIDTH_OF_COMMENT_TEXT_VIEW_WITH_WIDTH(width), 5000)].height;
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
  
  frame.size = [_commentTextView sizeThatFits:CGSizeMake(WIDTH_OF_COMMENT_TEXT_VIEW_WITH_WIDTH(self.frame.size.width), 5000)];
  frame.origin = CGPointMake(AVATAR_WIDTH+BEAK_WIDTH, HEADER_HEIGHT);
  if (!CGRectEqualToRect(_commentTextView.frame, frame)) {
    _commentTextView.frame = frame;
  }

  frame.size = CGSizeMake(self.frame.size.width-AVATAR_WIDTH, _commentTextView.frame.size.height);
  frame.origin = CGPointMake(AVATAR_WIDTH, HEADER_HEIGHT);
  if (!CGRectEqualToRect(_backgroundImageView.frame, frame)) {
    _backgroundImageView.frame = frame;
  }
  
  if (![_commentButton isHidden]) {
    frame.size = CGSizeMake(COMMENT_BUTTON_WIDTH, COMMENT_BUTTON_HEIGHT);
    frame.origin = CGPointMake(self.frame.size.width-COMMENT_BUTTON_WIDTH-COMMENT_OFFSET, _backgroundImageView.frame.origin.y+_backgroundImageView.frame.size.height+COMMENT_OFFSET);
    if (!CGRectEqualToRect(_commentButton.frame, frame)) {
      _commentButton.frame = frame;
    }
  }
}

@end
