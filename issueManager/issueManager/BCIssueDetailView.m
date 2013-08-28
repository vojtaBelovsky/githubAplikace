//
//  BCIssueDetailView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/26/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueDetailView.h"
#import "BCIssue.h"
#import "UIImageView+AFNetworking.h"
#import "BCUser.h"
#import "BCIssueDetailViewController.h"
#import "BCLabel.h"
#import "BCMilestone.h"
#import "BCSingleIssueView.h"
#import "BCHeadeView.h"
#import "BCComment.h"
#import "BCCommentView.h"
#import "UIAlertView+errorAlert.h"

#define BACKGROUND_IMAGE              [UIImage imageNamed:@"appBackground.png"]
#define BACK_BUTTON_IMG               [UIImage imageNamed:@"issueNavbarXOff.png"]
#define BACK_BUTTON_IMG_HL            [UIImage imageNamed:@"issueNavbarXOn.png"]
#define CLOSE_BUTTON_IMG              [UIImage imageNamed:@"issueNavbarCheckOff.png"]
#define CLOSE_BUTTON_IMG_HL           [UIImage imageNamed:@"issueNavbarCheckOn.png"]
#define COMMENT_BUTTON_IMG            [UIImage imageNamed:@"issueCommentButtonOn.png"]
#define COMMENT_BUTTON_IMG_HL         [UIImage imageNamed:@"issueCommentButtonOff.png"]

#define ISSUE_WIDTH                   ( 300.0f )
#define OFFSET                        ( 10.f )
#define NAV_BAR_HEIGHT                ( 70.0f )
#define HEADER_HEIGHT                 ( 40.0f )

#define USER_FONT                [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define USER_FONT_COLOR          [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]
#define USER_SHADOW_FONT_COLOR   [UIColor whiteColor]

#define TITLE_FONT               [UIFont fontWithName:@"ProximaNova-Semibold" size:16]

#define CommentButtonFrameWithOrigin(x, y) CGRectMake(x, y, COMMENT_BUTTON_WIDTH, COMMENT_BUTTON_HEIGHT)

@implementation BCIssueDetailView

-(id) initWithIssue:(BCIssue *)issue andController:(BCIssueDetailViewController *)controller{
    self = [super init];
    if(self){
      _issue = issue;
      _myNewCommentView = nil;
      _addedNewComment = NO;
      _sizeOfKeyborad = 0;
      [self setScrollEnabled:YES];
      
      UIImage *resizableImage = [BACKGROUND_IMAGE stretchableImageWithLeftCapWidth:5 topCapHeight:64];
      _backgroundImageView = [[UIImageView alloc] initWithImage:resizableImage];
      [self addSubview:_backgroundImageView];
      
      _navigationBarView = [[UIImageView alloc] init];
      [_navigationBarView setBackgroundColor:[UIColor clearColor]];
      [self addSubview:_navigationBarView];
      
      _userNameShadowLabel = [[UILabel alloc] init];
      _userNameShadowLabel.numberOfLines = 0;
      _userNameShadowLabel.font = USER_FONT;
      _userNameShadowLabel.textColor = USER_SHADOW_FONT_COLOR;
      _userNameShadowLabel.backgroundColor = [UIColor clearColor];
      [_userNameShadowLabel setText:issue.assignee.userLogin];
      [self addSubview:_userNameShadowLabel];
      
      _userNameLabel = [[UILabel alloc] init];
      _userNameLabel.numberOfLines = 0;
      _userNameLabel.font = USER_FONT;
      _userNameLabel.textColor = USER_FONT_COLOR;
      _userNameLabel.backgroundColor = [UIColor clearColor];
      [_userNameLabel setText:issue.assignee.userLogin];
      [self addSubview:_userNameLabel];
      
      
      _backButton = [[UIButton alloc] init];
      [_backButton setImage:BACK_BUTTON_IMG forState:UIControlStateNormal];
      [_backButton setImage:BACK_BUTTON_IMG_HL forState:UIControlStateSelected];
      [self addSubview:_backButton];
      
      _closeButton = [[UIButton alloc] init];
      [_closeButton setImage:CLOSE_BUTTON_IMG forState:UIControlStateNormal];
      [_closeButton setImage:CLOSE_BUTTON_IMG_HL forState:UIControlStateSelected];
      [self addSubview:_closeButton];
      
      _headerView = [[BCHeadeView alloc] initWithFrame:CGRectMake(0, _navigationBarView.frame.size.height, self.frame.size.width, HEADER_HEIGHT) andMilestone:issue.milestone];
      [self addSubview:_headerView];
      
      _issueView = [[BCSingleIssueView alloc] initWithTitleFont:TITLE_FONT showAll:YES offset:OFFSET];
      [_issueView setWithIssue:issue];
      [self addSubview:_issueView];
      
      _commentViews = [[NSMutableArray alloc] init];
      [BCComment getCommentsForIssue:issue withSuccess:^(NSMutableArray *comments) {
        BCCommentView *commentView;
        for (BCComment *comment in comments) {
          commentView = [[BCCommentView alloc] initWithComment:comment];
          [self addSubview:commentView];
          [_commentViews addObject:commentView];
        }
      } failure:^(NSError *error) {
        [UIAlertView showWithError:error];
      }];
      
      _addNewCommentButton = [[UIButton alloc] init];
      [_addNewCommentButton setImage:COMMENT_BUTTON_IMG forState:UIControlStateNormal];
      [_addNewCommentButton setImage:COMMENT_BUTTON_IMG_HL forState:UIControlStateSelected];
      [self addSubview:_addNewCommentButton];
    }
    return self;
}

-(void) layoutSubviews{
  [super layoutSubviews];
  CGRect frame= CGRectZero;
  
  frame = CGRectMake(0, 0, self.frame.size.width, NAV_BAR_HEIGHT);
  if(!CGRectEqualToRect(_navigationBarView.frame, frame)){
    _navigationBarView.frame = frame;
  }
  
  frame.size = [_backButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(!CGRectEqualToRect(_backButton.frame, frame)){
    _backButton.frame = frame;
  }
  
  frame.size = [_userNameShadowLabel sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(((self.frame.size.width-frame.size.width)/2)+1, ((self.navigationBarView.frame.size.height-frame.size.height)/2)+1);
  if(!CGRectEqualToRect(_userNameShadowLabel.frame, frame)){
    _userNameShadowLabel.frame = frame;
  }
  
  frame.size = [_userNameLabel sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(((self.frame.size.width-frame.size.width)/2), ((self.navigationBarView.frame.size.height-frame.size.height)/2));
  if(!CGRectEqualToRect(_userNameLabel.frame, frame)){
    _userNameLabel.frame = frame;
  }
  
  
  frame.size = [_closeButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake((_navigationBarView.frame.size.width-frame.size.width)-15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(!CGRectEqualToRect(_closeButton.frame, frame)){
    _closeButton.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.width, HEADER_HEIGHT);
  frame.origin = CGPointMake(0, _navigationBarView.frame.size.height);
  if (!CGRectEqualToRect(_headerView.frame, frame)) {
    _headerView.frame = frame;
  }
  
  frame.size = CGSizeMake(ISSUE_WIDTH, [BCSingleIssueView sizeOfSingleIssueViewWithIssue:_issue width:ISSUE_WIDTH offset:OFFSET titleFont:TITLE_FONT showAll:YES].height);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, _navigationBarView.frame.size.height+HEADER_HEIGHT);
  if (!CGRectEqualToRect(_issueView.frame, frame)) {
    _issueView.frame = frame;
  }
  
  if (_myNewCommentView != nil && _addedNewComment) {
    [_commentViews addObject:_myNewCommentView];
  }
  frame.origin.y = NAV_BAR_HEIGHT+HEADER_HEIGHT+_issueView.frame.size.height+OFFSET;
  frame.origin.x = (self.frame.size.width-ISSUE_WIDTH)/2;
  for (BCCommentView *commentView in _commentViews) {
    frame.size = [commentView sizeOfViewWithWidth:ISSUE_WIDTH];
    if (!CGRectEqualToRect(commentView.frame, frame)) {
      if (![commentView.commentButton isHidden]) {
        frame.size.height += COMMENT_BUTTON_HEIGHT+COMMENT_OFFSET;
      }
      commentView.frame = frame;
    }
    frame.origin.y += commentView.frame.size.height+OFFSET;
  }
  
  if (_addedNewComment == NO && _myNewCommentView == nil) {
    frame.origin.y += OFFSET;
    frame.size = [_addNewCommentButton sizeThatFits:self.frame.size];
    frame.origin.x = (self.frame.size.width-frame.size.width)/2;
    if (!CGRectEqualToRect(_addNewCommentButton.frame, frame)) {
      _addNewCommentButton.frame = frame;
    }
    [_addNewCommentButton setHidden:NO];
  }else{
    //pridat tlacitko na odeslani komentare
    [_addNewCommentButton setHidden:YES];
    _addedNewComment = NO;
  }
  
  frame.size.height = frame.origin.y+_addNewCommentButton.frame.size.height+3*OFFSET+_sizeOfKeyborad;
  frame.size.width = self.frame.size.width;
  if (!CGSizeEqualToSize(self.contentSize, frame.size)) {
    self.contentSize = frame.size;
  }
  
  frame.origin = CGPointZero;
  frame.size.width = self.frame.size.width;
  if (self.frame.size.height > frame.size.height) {
    frame.size.height = self.frame.size.height;
  }
  if (!CGRectEqualToRect(_backgroundImageView.frame, frame)){
    _backgroundImageView.frame = frame;
  }
}

@end
