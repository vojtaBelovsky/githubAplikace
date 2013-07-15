//
//  BCaddIssueButton.m
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCaddIssueButton.h"

#define TITLE_FONT_COLOR    [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define COMMENT_FONT_COLOR  [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1.00]
#define TITLE_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:14]

#define NEW_ISSUE_PLUS_OFF  [UIImage imageNamed:@"newIssuePlusOff.png"]
#define NEW_ISSUE_PLUS_ON   [UIImage imageNamed:@"newIssuePlusOn.png"]
#define NEW_ISSUE_SEPARATOR [UIImage imageNamed:@"newIssueSeparator.png"]

@implementation BCaddIssueButton

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title{
  self = [super initWithFrame:frame];
  if (self) {
    //_havePlus = issuePlus;
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:title];
    [_titleLabel setTextColor:TITLE_FONT_COLOR];
    [_titleLabel setFont:TITLE_FONT];
    CGRect frame;
    frame.size = [_titleLabel sizeThatFits:self.frame.size];
    frame.origin = CGPointMake(15, (self.frame.size.height-frame.size.height)/2);
    _titleLabel.frame = frame;
    [self addSubview:_titleLabel];
    
    if (_havePlus) {
      _theNewIssuePlus = [[UIButton alloc] init];
      [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_OFF forState:UIControlStateNormal];
      [_theNewIssuePlus setImage:NEW_ISSUE_PLUS_ON forState:UIControlStateHighlighted];
      frame.size = [_theNewIssuePlus sizeThatFits:self.frame.size];
      frame.origin = CGPointMake((self.frame.size.width-frame.size.width)-15, (self.frame.size.height-frame.size.height)/2);
      _theNewIssuePlus.frame = frame;
      [self addSubview:_theNewIssuePlus];
    }
    
    UIImage *image = [NEW_ISSUE_SEPARATOR stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    frame.size = CGSizeMake(self.frame.size.width, 1);
    frame.origin = CGPointMake(0, self.frame.size.height-1);
    _separatorImgView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_separatorImgView];
  }
  return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
