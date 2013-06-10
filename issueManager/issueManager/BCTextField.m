//
//  BCTextField.m
//  issueManager
//
//  Created by Vojtech Belovsky on 6/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCTextField.h"

#define ICON_PADDING        15.0f
#define TEXT_FIELD_PADDING  25.0f

#define TEXT_FIELD_FONT   [UIFont fontWithName:@"Proxima Nova Regular" size:28.0f]

#define TEXT_FIELD_BACKGROUND [UIColor clearColor]

@implementation BCTextField

#pragma mark - Lifecycles

- (id)initWithBackground:(UIImage *)backgroundImage icon:(UIImage *)iconImage {
  self = [super initWithFrame:CGRectZero];
  if ( self ) {
    UIImage *resizableImage = [backgroundImage stretchableImageWithLeftCapWidth:11 topCapHeight:11];
    _backgroundView = [[UIImageView alloc] initWithImage:resizableImage];
    
    _iconView = [[UIImageView alloc] initWithImage:iconImage];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    _textField.backgroundColor = TEXT_FIELD_BACKGROUND;
    _textField.font = TEXT_FIELD_FONT;
    _textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [self addSubview:_backgroundView];    
    [self addSubview:_textField];
    [self addSubview:_iconView];
  }
  
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGRect frame = CGRectZero;
  frame.size = self.frame.size;
  if ( !CGRectEqualToRect( frame, _backgroundView.frame ) ) {
    _backgroundView.frame = frame;
  }
  
  frame = _iconView.frame;
  frame.origin.y = ( CGRectGetHeight( self.frame ) - CGRectGetHeight( frame ) ) / 2;
  frame.origin.x = ICON_PADDING;
  if ( !CGRectEqualToRect( _iconView.frame, frame ) ) {
    _iconView.frame = frame;
  }
  
  frame.origin.x = CGRectGetMaxX( _iconView.frame ) + TEXT_FIELD_PADDING;
  frame.origin.y = 0.0f;
  frame.size.width = CGRectGetWidth( self.frame ) - CGRectGetMinX( frame );
  frame.size.height = CGRectGetHeight( self.frame );
  if ( !CGRectEqualToRect( _textField.frame, frame ) ) {
    _textField.frame = frame;
  }
}
@end
