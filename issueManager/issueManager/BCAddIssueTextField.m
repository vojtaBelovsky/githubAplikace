//
//  BCAddIssueTextField.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCAddIssueTextField.h"

#define TITLE_FONT_COLOR        [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define TITLE_TEXT_FONT_COLOR   [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]
#define TITLE_FONT              [UIFont fontWithName:@"ProximaNova-Regular" size:16]
#define TITLE_TEXT_FONT         [UIFont fontWithName:@"ProximaNova-Regular" size:16]

#define TITLE_OFFSET ( 15.0f )

#define NEW_ISSUE_PLUS_OFF    [UIImage imageNamed:@"newIssuePlusOff.png"]
#define NEW_ISSUE_PLUS_ON     [UIImage imageNamed:@"newIssuePlusOn.png"]
#define NEW_ISSUE_SEPARATOR   [UIImage imageNamed:@"newIssueSeparator.png"]


@implementation BCAddIssueTextField

- (id)initWithTitle:(NSString *)title
{
  self = [super init];
    if (self) {
      _myLabel = [[UILabel alloc] init];
      [_myLabel setText:title];
      [_myLabel setTextColor:TITLE_FONT_COLOR];
      [_myLabel setFont:TITLE_FONT];
      [self addSubview:_myLabel];
      
      _textField = [[UITextField alloc] init];
      [_textField setFont:TITLE_FONT];
      [_textField setTextColor:TITLE_TEXT_FONT_COLOR];
      [self addSubview:_textField];
      
      UIImage *image = [NEW_ISSUE_SEPARATOR stretchableImageWithLeftCapWidth:0 topCapHeight:1];
      _separatorImgView = [[UIImageView alloc] initWithImage:image];
      [self addSubview:_separatorImgView];
    }
  return self;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = [_myLabel sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(TITLE_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_myLabel.frame, frame)) {
    _myLabel.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.width-_myLabel.frame.size.width-(3*TITLE_OFFSET), _textField.font.lineHeight);
  frame.origin = CGPointMake(_myLabel.frame.size.width+(2*TITLE_OFFSET), (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_textField.frame, frame)) {
    _textField.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.width, 1);
  frame.origin = CGPointMake(0, self.frame.size.height-1);
  if (!CGRectEqualToRect(_separatorImgView.frame, frame)) {
    _separatorImgView.frame = frame;
  }
}

@end
