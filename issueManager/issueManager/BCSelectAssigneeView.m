//
//  BCSelectAssigneeView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeView.h"

#define BACKGROUND_IMAGE              [UIImage imageNamed:@"appBackground.png"]
#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]
#define NEW_ISSUE_SEPARATOR           [UIImage imageNamed:@"newIssueSeparator.png"]
#define NEW_ISSUE_CHECK_ON            [UIImage imageNamed:@"newIssueCheckOn.png"]
#define NEW_ISSUE_CHECK_OFF           [UIImage imageNamed:@"newIssueCheckOff.png"]

#define TABLE_WIDTH          ( 300.0f )
#define TABLE_HEIGHT         ( 300.0f )
#define TABLE_OFFSET         ( 50.0f )
#define TABLE_LINE_WIDTH     ( 292.0f )
#define TABLE_LINE_HEIGHT    ( 40.0f )

#define NEW_ISSUE_FONT                [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define NEW_ISSUE_FONT_COLOR          [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00];
#define NEW_ISSUE_SHADOW_FONT_COLOR   [UIColor whiteColor]

#define DONE_AND_CANCEL_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:14]
#define DONE_AND_CANCEL_FONT_COLOR    [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00];

@implementation BCSelectAssigneeView

- (id)init
{
    self = [super init];
    if (self) {
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
      [_theNewIssueShadowLabel setText:@"Select Milestone"];
      [self addSubview:_theNewIssueShadowLabel];
      
      _theNewIssueLabel = [[UILabel alloc] init];
      _theNewIssueLabel.numberOfLines = 0;
      _theNewIssueLabel.font = NEW_ISSUE_FONT;
      _theNewIssueLabel.textColor = NEW_ISSUE_FONT_COLOR;
      _theNewIssueLabel.backgroundColor = [UIColor clearColor];
      [_theNewIssueLabel setText:@"Select Assignee"];
      [self addSubview:_theNewIssueLabel];
      
      
      _cancelButton = [[UIButton alloc] init];
      _cancelButton.titleLabel.numberOfLines = 0;
      _cancelButton.titleLabel.font = DONE_AND_CANCEL_FONT;
      _cancelButton.titleLabel.textColor = [UIColor blackColor];
      _cancelButton.titleLabel.backgroundColor = [UIColor clearColor];
      [_cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
      [_cancelButton setEnabled:YES];
      [self addSubview:_cancelButton];
      
      _doneButton = [[UIButton alloc] init];
      _doneButton.titleLabel.numberOfLines = 0;
      _doneButton.titleLabel.font = DONE_AND_CANCEL_FONT;
      _doneButton.titleLabel.textColor = DONE_AND_CANCEL_FONT_COLOR;
      _doneButton.titleLabel.backgroundColor = [UIColor clearColor];
      [_doneButton setTitle:@"DONE" forState:UIControlStateNormal];
      [_doneButton setEnabled:YES];
      [self addSubview:_doneButton];
      
      resizableImage = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:8 topCapHeight:8];
      _issueForm = [[UIImageView alloc] initWithImage:resizableImage];
      [self addSubview:_issueForm];
      
      _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
      //      [_tableView setAllowsMultipleSelection:YES];
      _tableView.backgroundColor = [UIColor clearColor];
      _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
      [self addSubview:_tableView];
    }
    return self;
}

-(void) layoutSubviews{
  [super layoutSubviews];
  
  CGRect frame= CGRectZero;
  frame.size = self.bounds.size;
  if ( !CGRectEqualToRect( frame, _backgroundImageView.frame ) ) {
    _backgroundImageView.frame = frame;
  }
  
  frame = CGRectMake(0, 0, self.frame.size.width, TABLE_OFFSET);
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
  
  
  frame.size = [_doneButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake((_navigationBarView.frame.size.width-frame.size.width)-15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_doneButton.frame, frame)){
    _doneButton.frame = frame;
  }
  
  frame.size = CGSizeMake(TABLE_WIDTH, TABLE_HEIGHT);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, TABLE_OFFSET);
  if(! CGRectEqualToRect(_issueForm.frame, frame)){
    _issueForm.frame = frame;
  }
  
  frame.size = CGSizeMake(TABLE_LINE_WIDTH, TABLE_HEIGHT);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, TABLE_OFFSET);
  if(!CGRectEqualToRect(_tableView.frame, frame)){
    _tableView.frame = frame;
  }
}


@end
