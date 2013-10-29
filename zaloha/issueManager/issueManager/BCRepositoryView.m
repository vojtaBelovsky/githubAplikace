//
//  BCRepositoryView.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/28/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryView.h"
#import <QuartzCore/QuartzCore.h>
#import "BCConstants.h"

#define BACKGROUND_IMAGE  [UIImage imageNamed:@"repositories_background.png"]

#define REPOSITORIES_FONT               [UIFont fontWithName:@"ProximaNova-Light" size:24]
#define REPOSITORIES_FONT_COLOR         [UIColor colorWithRed:.44 green:.44 blue:.44 alpha:1.00]
#define REPOSITORIES_SHADOW_COLOR       [UIColor blackColor]

#define CONFIRM_FONT            [UIFont fontWithName:@"ProximaNova-Light" size:13]
#define CONFIRM_FONT_COLOR      [UIColor whiteColor]
#define REPOSITORY_BG_COLOR     [UIColor colorWithRed:.11 green:.11 blue:.11 alpha:1.00]

@implementation BCRepositoryView

#pragma mark -
#pragma mark LifeCycles

- (id)initWithButtonTitle:(NSString*)title {
  self = [super init];
  if ( self ) {
    UIImage *resizableImage = [BACKGROUND_IMAGE stretchableImageWithLeftCapWidth:10 topCapHeight:86];
    _backgroundImageView = [[UIImageView alloc] initWithImage:resizableImage];
    [self addSubview:_backgroundImageView];
    
    _navBarView = [[UIView alloc] init];
    [_navBarView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_navBarView];
    
    _repositoryLabel = [[UILabel alloc] init];
    _repositoryLabel.numberOfLines = 0;
    _repositoryLabel.font = REPOSITORIES_FONT;
    _repositoryLabel.textColor = REPOSITORIES_FONT_COLOR;
    _repositoryLabel.backgroundColor = [UIColor clearColor];
    _repositoryLabel.layer.shadowOpacity = 1.0;
    _repositoryLabel.layer.shadowRadius = 0.0;
    _repositoryLabel.layer.shadowColor = REPOSITORIES_SHADOW_COLOR.CGColor;
    _repositoryLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    [_repositoryLabel setText:@"Repositories"];
    [self addSubview:_repositoryLabel];
    
    _confirmButton = [[UIButton alloc] init];
    [_confirmButton setTitle:title forState:UIControlStateNormal];
    [_confirmButton setTitleColor:CONFIRM_FONT_COLOR forState:UIControlStateNormal];
    _confirmButton.titleLabel.backgroundColor = [UIColor clearColor];
    _confirmButton.titleLabel.numberOfLines = 0;
    _confirmButton.titleLabel.font = CONFIRM_FONT;
    _confirmButton.enabled = YES;
    _confirmButton.layer.shadowOpacity = 1.0;
    _confirmButton.layer.shadowRadius = 0.0;
    _confirmButton.layer.shadowColor = REPOSITORIES_SHADOW_COLOR.CGColor;
    _confirmButton.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    [self addSubview:_confirmButton];
    
    _tableView = [[UITableView alloc] init];
    [_tableView setAllowsMultipleSelection:YES];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_activityIndicatorView setColor:ACTIVITY_INDICATOR_COLOR];
    [_activityIndicatorView setAlpha:ACTIVITY_INDICATOR_ALPHA];
    [_activityIndicatorView setBackgroundColor:ACTIVITY_INDICATOR_BACKGROUND];
    [_activityIndicatorView.layer setBorderWidth:1];
    [_activityIndicatorView.layer setBorderColor:ACTIVITY_INDICATOR_BORDER.CGColor];
    [_activityIndicatorView.layer setCornerRadius:ACTIVITY_CORNER_RADIUS];
    [_activityIndicatorView.layer setBackgroundColor:ACTIVITY_INDICATOR_BACKGROUND.CGColor];
    [self addSubview:_activityIndicatorView];
    
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
  if( !CGRectEqualToRect(_backgroundImageView.frame, frame)){
    _backgroundImageView.frame = frame;
  }
  
  frame = CGRectMake(0, 0, self.frame.size.width, NAV_BAR_HEIGHT);
  if( !CGRectEqualToRect(_navBarView.frame, frame)){
    _navBarView.frame = frame;
  }

  frame.size = CGSizeMake(self.frame.size.width, self.frame.size.height-NAV_BAR_HEIGHT);
  frame.origin = CGPointMake(0, NAV_BAR_HEIGHT);
  if ( !CGRectEqualToRect( _tableView.frame, frame ) ) {
    _tableView.frame = frame;
  }
  
  frame.size = [_repositoryLabel sizeThatFits:_navBarView.frame.size];
  frame.origin = CGPointMake((_navBarView.frame.size.width-frame.size.width)/2, (_navBarView.frame.size.height-frame.size.height)/2);
  if( !CGRectEqualToRect(_repositoryLabel.frame, frame)){
    _repositoryLabel.frame = frame;
  }
  
  frame.size = [_confirmButton sizeThatFits:_navBarView.frame.size];
  frame.size.height = NAV_BAR_HEIGHT;
  frame.origin = CGPointMake((_navBarView.frame.size.width-frame.size.width)-10, (_navBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_confirmButton.frame, frame)){
    _confirmButton.frame = frame;
  }
  
  frame.size = ACTIVITY_INDICATOR_SIZE;
  frame.origin = _activityIndicatorView.frame.origin;
  if (!CGRectEqualToRect(_activityIndicatorView.frame, frame)) {
    _activityIndicatorView.frame = frame;
  }
  
  if (!CGPointEqualToPoint(_activityIndicatorView.center, self.center)) {
    _activityIndicatorView.center = self.center;
  }
}

@end
