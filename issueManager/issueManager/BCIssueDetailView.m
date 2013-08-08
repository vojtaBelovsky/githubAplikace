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
#import "BCIssueInDetailView.h"

#define BACKGROUND_IMAGE              [UIImage imageNamed:@"appBackground.png"]
#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]
#define NEW_ISSUE_SEPARATOR           [UIImage imageNamed:@"newIssueSeparator.png"]
#define BACK_BUTTON_IMG               [UIImage imageNamed:@"issueNavbarXOff.png"]
#define BACK_BUTTON_IMG_HL            [UIImage imageNamed:@"issueNavbarXOn.png"]
#define CLOSE_BUTTON_IMG              [UIImage imageNamed:@"issueNavbarCheckOff.png"]
#define CLOSE_BUTTON_IMG_HL           [UIImage imageNamed:@"issueNavbarCheckOn.png"]

#define ISSUE_FORM_WIDTH              ( 300.0f )
#define NEW_ISSUE_FORM_HEIGHT         ( 400.0f )
#define NEW_ISSUE_FORM_OFFSET         ( 50.0f )
#define NEW_ISSUE_FORM_LINE_WIDTH     ( 292.0f )
#define NEW_ISSUE_FORM_LINE_HEIGHT    ( 40.0f )
#define NEW_ISSUE_SHADOW_HEIGHT       ( 4.0f )

#define NEW_ISSUE_FONT                [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define NEW_ISSUE_FONT_COLOR          [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]
#define NEW_ISSUE_SHADOW_FONT_COLOR   [UIColor whiteColor]

#define BODY_PLACEHOLDER_FONT_COLOR     [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1.00]
#define BODY_FONT_ITALIC       [UIFont fontWithName:@"ProximaNova-RegItalic" size:16]

#define TITLE_FONT          [UIFont fontWithName:@"ProximaNova-Semibold" size:16]

@implementation BCIssueDetailView

-(id) initWithIssue:(BCIssue *)issue andController:(BCIssueDetailViewController *)controller{
    self = [super init];
    if(self){
      _issue = issue;
      
      UIImage *resizableImage = [BACKGROUND_IMAGE stretchableImageWithLeftCapWidth:5 topCapHeight:64];
      _backgroundImageView = [[UIImageView alloc] initWithImage:resizableImage];
      [self addSubview:_backgroundImageView];
      
      _navigationBarView = [[UIImageView alloc] init];
      [_navigationBarView setBackgroundColor:[UIColor clearColor]];
      [self addSubview:_navigationBarView];
      
      _theNewIssueShadowLabel = [[UILabel alloc] init];
      _theNewIssueShadowLabel.numberOfLines = 0;
      _theNewIssueShadowLabel.font = NEW_ISSUE_FONT;
      _theNewIssueShadowLabel.textColor = NEW_ISSUE_SHADOW_FONT_COLOR;
      _theNewIssueShadowLabel.backgroundColor = [UIColor clearColor];
      [_theNewIssueShadowLabel setText:issue.assignee.userLogin];
      [self addSubview:_theNewIssueShadowLabel];
      
      _theNewIssueLabel = [[UILabel alloc] init];
      _theNewIssueLabel.numberOfLines = 0;
      _theNewIssueLabel.font = NEW_ISSUE_FONT;
      _theNewIssueLabel.textColor = NEW_ISSUE_FONT_COLOR;
      _theNewIssueLabel.backgroundColor = [UIColor clearColor];
      [_theNewIssueLabel setText:issue.assignee.userLogin];
      [self addSubview:_theNewIssueLabel];
      
      
      _backButton = [[UIButton alloc] init];
      [_backButton setImage:BACK_BUTTON_IMG forState:UIControlStateNormal];
      [_backButton setImage:BACK_BUTTON_IMG_HL forState:UIControlStateSelected];
      [self addSubview:_backButton];
      
      _closeButton = [[UIButton alloc] init];
      [_closeButton setImage:CLOSE_BUTTON_IMG forState:UIControlStateNormal];
      [_closeButton setImage:CLOSE_BUTTON_IMG_HL forState:UIControlStateSelected];
      [self addSubview:_closeButton];
      
      _issueView = [[BCIssueInDetailView alloc] initWithIssue:issue];
      [self addSubview:_issueView];
    }
    return self;
}

-(void) rewriteContentWithIssue:(BCIssue *)issue{
  
}

-(void) layoutSubviews{
  [super layoutSubviews];
  
  CGRect frame= CGRectZero;
  frame.size = self.bounds.size;
  if ( !CGRectEqualToRect( frame, _backgroundImageView.frame ) ) {
    _backgroundImageView.frame = frame;
  }
  
  frame = CGRectMake(0, 0, self.frame.size.width, NEW_ISSUE_FORM_OFFSET);
  if(! CGRectEqualToRect(_navigationBarView.frame, frame)){
    _navigationBarView.frame = frame;
  }
  
  frame.size = [_backButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_backButton.frame, frame)){
    _backButton.frame = frame;
  }
  
  frame.size = [_theNewIssueShadowLabel sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(((self.frame.size.width-frame.size.width)/2)+1, ((self.navigationBarView.frame.size.height-frame.size.height)/2)+1);
  if( !CGRectEqualToRect(_theNewIssueShadowLabel.frame, frame)){
    _theNewIssueShadowLabel.frame = frame;
  }
  
  frame.size = [_theNewIssueLabel sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(((self.frame.size.width-frame.size.width)/2), ((self.navigationBarView.frame.size.height-frame.size.height)/2));
  if( !CGRectEqualToRect(_theNewIssueLabel.frame, frame)){
    _theNewIssueLabel.frame = frame;
  }
  
  
  frame.size = [_closeButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake((_navigationBarView.frame.size.width-frame.size.width)-15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_closeButton.frame, frame)){
    _closeButton.frame = frame;
  }
  
  frame.size = CGSizeMake(ISSUE_FORM_WIDTH, [BCIssue heightOfIssueInDetailWithIssue:_issue withFont:TITLE_FONT]);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, _navigationBarView.frame.size.height);
  if (!CGRectEqualToRect(_issueView.frame, frame)) {
    _issueView.frame = frame;
  }
}

@end
