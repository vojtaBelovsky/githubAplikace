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
#import "BCAddIssueButtonMC.h"
#import <QuartzCore/QuartzCore.h>
#import "SZTextView.h"

#define BACKGROUND_IMAGE              [UIImage imageNamed:@"appBackground.png"]
#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]
#define NEW_ISSUE_SEPARATOR           [UIImage imageNamed:@"newIssueSeparator.png"]

#define TABLE_WIDTH          ( 0.9f )
#define LINE_WIDTH           ( 0.972f )
#define NAV_BAR_HEIGHT       ( 44.0f )
#define TABLE_LINE_HEIGHT    ( 40.0f )
#define CAP_SIZE_FOR_FORM    ( 8.0f )

#define NEW_ISSUE_FONT                  [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define NEW_ISSUE_FONT_COLOR            [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]
#define NEW_ISSUE_SHADOW_FONT_COLOR     [UIColor whiteColor]

#define BODY_PLACEHOLDER_FONT_COLOR     [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1.00]
#define BODY_FONT_ITALIC                [UIFont fontWithName:@"ProximaNova-RegItalic" size:16]

#define DONE_AND_CANCEL_FONT            [UIFont fontWithName:@"ProximaNova-Regular" size:14]
#define DONE_AND_CANCEL_FONT_COLOR      [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]


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
      
      _theNewIssueLabel = [[UILabel alloc] init];
      _theNewIssueLabel.numberOfLines = 0;
      _theNewIssueLabel.font = NEW_ISSUE_FONT;
      _theNewIssueLabel.textColor = NEW_ISSUE_FONT_COLOR;
      _theNewIssueLabel.backgroundColor = [UIColor clearColor];
      _theNewIssueLabel.layer.shadowOpacity = 1.0;
      _theNewIssueLabel.layer.shadowRadius = 0.0;
      _theNewIssueLabel.layer.shadowColor = NEW_ISSUE_SHADOW_FONT_COLOR.CGColor;
      _theNewIssueLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
      [_theNewIssueLabel setText:@"New Issue"];
      [self addSubview:_theNewIssueLabel];      
      
      _cancelButton = [[UIButton alloc] init];
      _cancelButton.titleLabel.numberOfLines = 0;
      _cancelButton.titleLabel.font = DONE_AND_CANCEL_FONT;
      [_cancelButton setTitleColor:DONE_AND_CANCEL_FONT_COLOR forState:UIControlStateNormal];
      _cancelButton.titleLabel.backgroundColor = [UIColor clearColor];
      [_cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
      [_cancelButton setEnabled:YES];
      [self addSubview:_cancelButton];
      
      _createButton = [[UIButton alloc] init];
      _createButton.titleLabel.numberOfLines = 0;
      _createButton.titleLabel.font = DONE_AND_CANCEL_FONT;
      [_createButton setTitleColor:DONE_AND_CANCEL_FONT_COLOR forState:UIControlStateNormal];
      _createButton.titleLabel.backgroundColor = [UIColor clearColor];
      [_createButton setTitle:@"CREATE" forState:UIControlStateNormal];
      [_createButton setEnabled:YES];
      [self addSubview:_createButton];
      
      resizableImage = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:8 topCapHeight:8];
      _issueForm = [[UIImageView alloc] initWithImage:resizableImage];
      [self addSubview:_issueForm];
      
      _issueTitle = [[BCAddIssueTextField alloc] initWithTitle:@"Title:"];
      [self addSubview:_issueTitle];
      
      _addMilestone = [[BCaddIssueButton alloc] initWithTitle:@"Milestone:"];
      [self addSubview:_addMilestone];
      
      _selectAssignee = [[BCaddIssueButton alloc] initWithTitle:@"Assigned:"];
      [self addSubview:_selectAssignee];
      
      _selectLabels = [[BCaddIssueButtonMC alloc] initWithTitle:@"Labels:"];
      [_selectLabels setOriginalHeight:TABLE_LINE_HEIGHT];
      [self addSubview:_selectLabels];
      
      _issueBody = [[SZTextView alloc] init];
      [_issueBody setFont:BODY_FONT_ITALIC];
      [_issueBody setPlaceholder:@"What is the problem?"];
      [_issueBody setPlaceholderTextColor:BODY_PLACEHOLDER_FONT_COLOR];
      [self addSubview:_issueBody];
    }
    return self;
}

-(void) rewriteContentWithAssignee:(BCUser *)assignee milestone:(BCMilestone *)milestone andLabels:(NSMutableArray *)labels{
  [_addMilestone setContentWithText:milestone.title];
  [_selectAssignee setContentWithText:assignee.userLogin];
  [_selectLabels setLabels:labels];
  [self setNeedsLayout];
}

-(void) layoutSubviews{
  [super layoutSubviews];
  
  CGRect frame= CGRectZero;
  frame.size = self.bounds.size;
  if ( !CGRectEqualToRect( frame, _backgroundImageView.frame ) ) {
    _backgroundImageView.frame = frame;
  }
  
  frame = CGRectMake(0, 0, self.frame.size.width, NAV_BAR_HEIGHT);
  if(! CGRectEqualToRect(_navigationBarView.frame, frame)){
    _navigationBarView.frame = frame;
  }
  
  frame.size = [_cancelButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_cancelButton.frame, frame)){
    _cancelButton.frame = frame;
  }
  
  frame.size = [_theNewIssueLabel sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(((self.frame.size.width-frame.size.width)/2), ((self.navigationBarView.frame.size.height-frame.size.height)/2));
  if( !CGRectEqualToRect(_theNewIssueLabel.frame, frame)){
    _theNewIssueLabel.frame = frame;
  }  
  
  frame.size = [_createButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake((_navigationBarView.frame.size.width-frame.size.width)-15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_createButton.frame, frame)){
    _createButton.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.width*TABLE_WIDTH, self.frame.size.height-2*NAV_BAR_HEIGHT);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, NAV_BAR_HEIGHT);
  if(! CGRectEqualToRect(_issueForm.frame, frame)){
    _issueForm.frame = frame;
  }
  
  frame.size = CGSizeMake(_issueForm.frame.size.width*LINE_WIDTH, TABLE_LINE_HEIGHT);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, NAV_BAR_HEIGHT);
  if(! CGRectEqualToRect(_issueTitle.frame, frame)){
    _issueTitle.frame = frame;
  }
  
  frame.origin = CGPointMake(frame.origin.x, frame.origin.y+TABLE_LINE_HEIGHT);
  if(! CGRectEqualToRect(_addMilestone.frame, frame)){
    _addMilestone.frame = frame;
  }
  
  frame.origin = CGPointMake(frame.origin.x, frame.origin.y+TABLE_LINE_HEIGHT);
  if (! CGRectEqualToRect(_selectAssignee.frame, frame)) {
    _selectAssignee.frame = frame;
  }
  
  frame.origin = CGPointMake(frame.origin.x, frame.origin.y+TABLE_LINE_HEIGHT);
  frame.size = [_selectLabels countMySizeWithWidth:frame.size.width];
  if (! CGRectEqualToRect(_selectLabels.frame, frame)) {
    [_selectLabels setFrame:frame];
  }
  
  frame.origin = CGPointMake(frame.origin.x, frame.origin.y+_selectLabels.frame.size.height);
  frame.size = CGSizeMake(frame.size.width, self.issueForm.frame.size.height-frame.origin.y);
  if (! CGRectEqualToRect(_issueBody.frame, frame)) {
    _issueBody.frame = frame;
  }
}

@end
