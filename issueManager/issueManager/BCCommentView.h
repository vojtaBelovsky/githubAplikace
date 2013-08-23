//
//  BCCommentView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/21/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCAvatarImgView;
@class BCComment;

@interface BCCommentView : UIView

@property UILabel *userName;
@property UILabel *commentedBefore;
@property BCAvatarImgView *avatar;
@property UIImageView *backgroundImageView;
@property UILabel *body;

- (id)initWithComment:(BCComment *)comment;
-(CGSize)sizeOfViewWithWidth:(CGFloat)width;

@end
