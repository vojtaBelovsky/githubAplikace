//
//  BCAddIssueTextField.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCAddIssueTextField.h"

#define TITLE_FONT_COLOR        [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define COMMENT_FONT_COLOR      [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1.00]
#define TITLE_TEXT_FONT_COLOR   [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]
#define TITLE_FONT              [UIFont fontWithName:@"ProximaNova-Regular" size:14]

#define TITLE_OFFSET ( 15.0f )

#define NEW_ISSUE_PLUS_OFF [UIImage imageNamed:@"newIssuePlusOff.png"]
#define NEW_ISSUE_PLUS_ON [UIImage imageNamed:@"newIssuePlusOn.png"]
#define NEW_ISSUE_SEPARATOR [UIImage imageNamed:@"newIssueSeparator.png"]

@implementation BCAddIssueTextField

- (id)initWithSize:(CGSize)size Title:(NSString *)title
{
  self = [super init];
    if (self) {
      [self setBackgroundColor:[UIColor grayColor]];
      
      _myLabel = [[UILabel alloc] init];
      [_myLabel setText:title];
      [_myLabel setTextColor:TITLE_FONT_COLOR];
      [_myLabel setFont:TITLE_FONT];
      CGRect frame;
      frame.size = [_myLabel sizeThatFits:size];
      frame.origin = CGPointMake(TITLE_OFFSET, (size.height-frame.size.height)/2);
      _myLabel.frame = frame;
      [self addSubview:_myLabel];     
      
      _textField = [[UITextField alloc] init];
      [_textField setFont:TITLE_FONT];
      [_textField setTextColor:TITLE_TEXT_FONT_COLOR];
      frame.size = CGSizeMake(size.width-_myLabel.frame.size.width-TITLE_OFFSET, size.height);
      frame.origin = CGPointMake(_myLabel.frame.size.width+TITLE_OFFSET, _myLabel.frame.origin.y);
      _textField.frame = frame;
      [self addSubview:_textField];
      
      UIImage *image = [NEW_ISSUE_SEPARATOR stretchableImageWithLeftCapWidth:0 topCapHeight:1];
      frame.size = CGSizeMake(size.width, 1);
      frame.origin = CGPointMake(0, size.height-1);
      _separatorImgView = [[UIImageView alloc] initWithImage:image];
      _separatorImgView.frame = frame;
      [self addSubview:_separatorImgView];
    }
  return self;
}

@end
