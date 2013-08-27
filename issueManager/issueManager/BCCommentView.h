//
//  BCCommentView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/21/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#define COMMENT_BODY_COLOR  [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]
#define COMMENT_BODY_FONT   [UIFont fontWithName:@"ProximaNova-Regular" size:14]
#define COMMENT_OFFSET      ( 5.0f )

#define COMMENT_BUTTON_WIDTH     ( 80.0f )
#define COMMENT_BUTTON_HEIGHT    ( 20.0f )

#import <UIKit/UIKit.h>
@class BCAvatarImgView;
@class BCComment;

@interface BCCommentView : UIView<UITextViewDelegate>

@property UILabel *userName;
@property UILabel *commentedBefore;
@property BCAvatarImgView *avatar;
@property UIImageView *backgroundImageView;
@property UITextView *commentTextView;
@property UIButton *commentButton;
@property int lastContentHeight;

-(void)setEnabledForCommenting;
-(void)setDisabledForCommenting;
- (id)initWithComment:(BCComment *)comment;
-(CGSize)sizeOfViewWithWidth:(CGFloat)width;

@end
