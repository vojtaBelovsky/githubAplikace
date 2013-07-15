//
//  BCAddIssueView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCAddIssueView.h"
#import "BCAddIssueViewController.h"
#import "BCUser.h"
#import "UIImageView+AFNetworking.h"
#import "BCMilestone.h"
#import "BCLabel.h"
#import "BCaddIssueButton.h"
#import "BCAddIssueTextField.h"

#define BACKGROUND_IMAGE              [UIImage imageNamed:@"appBackground.png"]
#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]
#define NEW_ISSUE_SEPARATOR           [UIImage imageNamed:@"newIssueSeparator.png"]

#define NEW_ISSUE_FORM_OFFSET         ( 50.0f )
#define NEW_ISSUE_FORM_LINE_WIDTH     ( 290.0f )
#define NEW_ISSUE_FORM_LINE_HEIGHT    ( 40.0f )

#define NEW_ISSUE_FONT                [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define NEW_ISSUE_FONT_COLOR          [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00];
#define NEW_ISSUE_SHADOW_FONT_COLOR   [UIColor whiteColor]

#define DONE_AND_CANCEL_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:14]
#define DONE_AND_CANCEL_FONT_COLOR    [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00];


@implementation BCAddIssueView

-(id) initWithController:(BCAddIssueViewController *)controller{
    self = [super init];
    if(self){
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
      [_theNewIssueShadowLabel setText:@"New Issue"];
      [self addSubview:_theNewIssueShadowLabel];
      
      _theNewIssueLabel = [[UILabel alloc] init];
      _theNewIssueLabel.numberOfLines = 0;
      _theNewIssueLabel.font = NEW_ISSUE_FONT;
      _theNewIssueLabel.textColor = NEW_ISSUE_FONT_COLOR;
      _theNewIssueLabel.backgroundColor = [UIColor clearColor];
      [_theNewIssueLabel setText:@"New Issue"];
      [self addSubview:_theNewIssueLabel];
      
      
      _cancelButton = [[UIButton alloc] init];
      _cancelButton.titleLabel.numberOfLines = 0;
      _cancelButton.titleLabel.font = DONE_AND_CANCEL_FONT;
      _cancelButton.titleLabel.textColor = [UIColor blackColor];
      _cancelButton.titleLabel.backgroundColor = [UIColor clearColor];
      [_cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
      [_cancelButton setEnabled:YES];
      [self addSubview:_cancelButton];
      
      _postButton = [[UIButton alloc] init];
      _postButton.titleLabel.numberOfLines = 0;
      _postButton.titleLabel.font = DONE_AND_CANCEL_FONT;
      _postButton.titleLabel.textColor = DONE_AND_CANCEL_FONT_COLOR;
      _postButton.titleLabel.backgroundColor = [UIColor clearColor];
      [_postButton setTitle:@"POST" forState:UIControlStateNormal];
      [_postButton setEnabled:YES];
      [self addSubview:_postButton];
      
      resizableImage = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:8 topCapHeight:8];
      _issueForm = [[UIImageView alloc] initWithImage:resizableImage];
      [self addSubview:_issueForm];
      
      CGSize lineSize = CGSizeMake(NEW_ISSUE_FORM_LINE_WIDTH, NEW_ISSUE_FORM_LINE_HEIGHT);
      _issueTitle = [[BCAddIssueTextField alloc] initWithSize:lineSize Title:@"Title:"];
      [self addSubview:_issueTitle];
      
    }
    return self;
}

-(void) rewriteContentWithAssignee:(BCUser *)assignee milestone:(BCMilestone *)milestone andLabels:(NSArray *)labels{
//    if(assignee.userId != 0){
//        [_avatar setImageWithURL:assignee.avatarUrl placeholderImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
//        [_assignee setTitle:assignee.userLogin forState:UIControlStateNormal];
//        [_assignee setBackgroundColor:[UIColor whiteColor]];
//        [_assignee setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }else{
//        [_avatar setImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
//        [_assignee setTitle:@"nobody is assigned" forState:UIControlStateNormal];
//        [_assignee setBackgroundColor:[UIColor grayColor]];
//        [_assignee setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }
//    
//    if(milestone.number != 0){
//        [_milestone setTitle:milestone.title forState:UIControlStateNormal];
//        [_milestone setBackgroundColor:[UIColor whiteColor]];
//        [_milestone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }else{
//        [_milestone setTitle:@"no milestone is assigned" forState:UIControlStateNormal];
//        [_milestone setBackgroundColor:[UIColor grayColor]];
//        [_milestone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }
//    
//    if(labels.count != 0){
//        NSMutableString *labelsInString = [[NSMutableString alloc] init];
//        for(BCLabel *object in labels){
//            [labelsInString insertString:object.name atIndex:[labelsInString length]];
//            [labelsInString insertString:@" " atIndex:[labelsInString length]];
//        }
//        [_labels setText:labelsInString];
//        [_labels setBackgroundColor:[UIColor whiteColor]];
//        [_labels setTextColor:[UIColor blackColor]];
//    }else{
//        [_labels setText:@"no label is assigned"];
//        [_labels setBackgroundColor:[UIColor grayColor]];
//        [_labels setTextColor:[UIColor whiteColor]];
//    }
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
  
  frame.size = [_cancelButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_cancelButton.frame, frame)){
    _cancelButton.frame = frame;
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
  
  
  frame.size = [_postButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake((_navigationBarView.frame.size.width-frame.size.width)-15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_postButton.frame, frame)){
    _postButton.frame = frame;
  }
  
  frame.size = CGSizeMake(300, 400);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, NEW_ISSUE_FORM_OFFSET);
  if(! CGRectEqualToRect(_issueForm.frame, frame)){
    _issueForm.frame = frame;
  }
  
  frame.size = CGSizeMake(NEW_ISSUE_FORM_LINE_WIDTH, NEW_ISSUE_FORM_LINE_HEIGHT);
  //frame.origin = CGPointMake((self.frame.size.width-NEW_ISSUE_FORM_LINE_WIDTH)/2, frame)
  if(! CGRectEqualToRect(_issueTitle.frame, frame)){
    _issueTitle.frame = frame;
  }
}

@end
