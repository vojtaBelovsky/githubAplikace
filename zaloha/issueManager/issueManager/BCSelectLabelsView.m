//
//  BCSelectLabelsView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectLabelsView.h"
#import "BCConstants.h"

#define BACKGROUND_IMAGE              [UIImage imageNamed:@"appBackground.png"]
#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]
#define NEW_ISSUE_SEPARATOR           [UIImage imageNamed:@"newIssueSeparator.png"]
#define NEW_ISSUE_CHECK_ON            [UIImage imageNamed:@"newIssueCheckOn.png"]
#define NEW_ISSUE_CHECK_OFF           [UIImage imageNamed:@"newIssueCheckOff.png"]

#define TABLE_WIDTH          ( 0.9f )
#define TABLE_LINE_HEIGHT    ( 40.0f )

#define CAP_SIZE_FOR_FORM   ( 8.0f )

#define NEW_ISSUE_FONT                [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define NEW_ISSUE_FONT_COLOR          [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]
#define NEW_ISSUE_SHADOW_FONT_COLOR   [UIColor whiteColor]

#define DONE_AND_CANCEL_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:14]
#define DONE_AND_CANCEL_FONT_COLOR    [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]

@implementation BCSelectLabelsView

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
    [_theNewIssueShadowLabel setText:@"Select Labels"];
    [self addSubview:_theNewIssueShadowLabel];
    
    _theNewIssueLabel = [[UILabel alloc] init];
    _theNewIssueLabel.numberOfLines = 0;
    _theNewIssueLabel.font = NEW_ISSUE_FONT;
    _theNewIssueLabel.textColor = NEW_ISSUE_FONT_COLOR;
    _theNewIssueLabel.backgroundColor = [UIColor clearColor];
    [_theNewIssueLabel setText:@"Select Labels"];
    [self addSubview:_theNewIssueLabel];
    
    
    _cancelButton = [[UIButton alloc] init];
    _cancelButton.titleLabel.numberOfLines = 0;
    _cancelButton.titleLabel.font = DONE_AND_CANCEL_FONT;
    [_cancelButton setTitleColor:DONE_AND_CANCEL_FONT_COLOR forState:UIControlStateNormal];
    _cancelButton.titleLabel.backgroundColor = [UIColor clearColor];
    [_cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    [_cancelButton setEnabled:YES];
    [self addSubview:_cancelButton];
    
    _doneButton = [[UIButton alloc] init];
    _doneButton.titleLabel.numberOfLines = 0;
    _doneButton.titleLabel.font = DONE_AND_CANCEL_FONT;
    [_doneButton setTitleColor:DONE_AND_CANCEL_FONT_COLOR forState:UIControlStateNormal];
    _doneButton.titleLabel.backgroundColor = [UIColor clearColor];
    [_doneButton setTitle:@"DONE" forState:UIControlStateNormal];
    [_doneButton setEnabled:YES];
    [self addSubview:_doneButton];
    
    resizableImage = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:CAP_SIZE_FOR_FORM topCapHeight:CAP_SIZE_FOR_FORM];
    _form = [[UIImageView alloc] initWithImage:resizableImage];
    [self addSubview:_form];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setAllowsMultipleSelection:YES];
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
  
  frame = CGRectMake(0, 0, self.frame.size.width, NAV_BAR_HEIGHT);
  if(! CGRectEqualToRect(_navigationBarView.frame, frame)){
    _navigationBarView.frame = frame;
  }
  
  frame.size = [_cancelButton sizeThatFits:_navigationBarView.frame.size];
  frame.size.width += 2*TAP_AREA_ADDITON;
  frame.size.height = NAV_BAR_HEIGHT;
  frame.origin = CGPointMake(0, (_navigationBarView.frame.size.height-frame.size.height)/2);
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
  frame.size.width += 2*TAP_AREA_ADDITON;
  frame.size.height = NAV_BAR_HEIGHT;
  frame.origin = CGPointMake((_navigationBarView.frame.size.width-frame.size.width), (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_doneButton.frame, frame)){
    _doneButton.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.width*TABLE_WIDTH, self.frame.size.height-2*NAV_BAR_HEIGHT);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, NAV_BAR_HEIGHT);
  if(! CGRectEqualToRect(_form.frame, frame)){
    _form.frame = frame;
  }
  
  frame.size = CGSizeMake(_form.frame.size.width-CAP_SIZE_FOR_FORM, self.frame.size.height-2*NAV_BAR_HEIGHT-TABLE_VIEW_HEIGHT_RDUCTION);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, NAV_BAR_HEIGHT+TABLE_VIEW_HEIGHT_RDUCTION/2);
  if(!CGRectEqualToRect(_tableView.frame, frame)){
    _tableView.frame = frame;
  }
}

@end
