//
//  BCSelectAssigneeView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeView.h"
#import "BCConstants.h"
#import <QuartzCore/QuartzCore.h>

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

@implementation BCSelectAssigneeView

- (id)init
{
    self = [super init];
    if (self) {
      //Nastavení pozadí obrazovky.
      UIImage *resizableImage = [BACKGROUND_IMAGE stretchableImageWithLeftCapWidth:5 topCapHeight:64];
      _backgroundImageView = [[UIImageView alloc] initWithImage:resizableImage];
      [self addSubview:_backgroundImageView];
      
      //Vytvoření mého navigation baru.
      _navigationBarView = [[UIImageView alloc] init];
      [_navigationBarView setBackgroundColor:[UIColor clearColor]];
      [self addSubview:_navigationBarView];
      
      //Nastavení titulku, jeho font, barva, stín a text.
      _theNewIssueLabel = [[UILabel alloc] init];
      _theNewIssueLabel.numberOfLines = 0;
      _theNewIssueLabel.font = NEW_ISSUE_FONT;
      _theNewIssueLabel.textColor = NEW_ISSUE_FONT_COLOR;
      _theNewIssueLabel.backgroundColor = [UIColor clearColor];
      _theNewIssueLabel.layer.shadowOpacity = 1.0;
      _theNewIssueLabel.layer.shadowRadius = 0.0;
      _theNewIssueLabel.layer.shadowColor = NEW_ISSUE_SHADOW_FONT_COLOR.CGColor;
      _theNewIssueLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
      [_theNewIssueLabel setText:@"Select Assignee"];
      [self addSubview:_theNewIssueLabel];
      
      //Vytvoření tlačítka pro akci zpět.
      _cancelButton = [[UIButton alloc] init];
      _cancelButton.titleLabel.numberOfLines = 0;
      _cancelButton.titleLabel.font = DONE_AND_CANCEL_FONT;
      [_cancelButton setTitleColor:DONE_AND_CANCEL_FONT_COLOR forState:UIControlStateNormal];
      _cancelButton.titleLabel.backgroundColor = [UIColor clearColor];
      [_cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
      [_cancelButton setEnabled:YES];
      [self addSubview:_cancelButton];
      
      //Vytvoření tlačítka pro potvrzení výběru.
      _doneButton = [[UIButton alloc] init];
      _doneButton.titleLabel.numberOfLines = 0;
      _doneButton.titleLabel.font = DONE_AND_CANCEL_FONT;
      [_doneButton setTitleColor:DONE_AND_CANCEL_FONT_COLOR forState:UIControlStateNormal];      _doneButton.titleLabel.backgroundColor = [UIColor clearColor];
      [_doneButton setTitle:@"DONE" forState:UIControlStateNormal];
      [_doneButton setEnabled:YES];
      [self addSubview:_doneButton];
      
      //Okraj rámečku - lemování kolem formuláře
      resizableImage = [BACKGROUND_IMAGE_FOR_FORM stretchableImageWithLeftCapWidth:CAP_SIZE_FOR_FORM topCapHeight:CAP_SIZE_FOR_FORM];
      _form = [[UIImageView alloc] initWithImage:resizableImage];
      [self addSubview:_form];
      
      //samotná tabulka pro výběr spolupracovníka
      _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
      _tableView.backgroundColor = [UIColor clearColor];
      _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
      [_tableView setBackgroundColor:[UIColor clearColor]];
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
