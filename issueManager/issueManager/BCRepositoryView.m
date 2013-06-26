//
//  BCRepositoryView.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/28/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryView.h"

#define REPOSITORY_BG_COLOR  [UIColor colorWithRed:.11 green:.11 blue:.11 alpha:1.00]
#define BACKGROUND_IMAGE        [UIImage imageNamed:@"repositories_gradient.png"]

#define TABLE_VIEW_OFFSET         ( 50.0f )

#define REPOSITORIES_FONT            [UIFont fontWithName:@"ProximaNova-Light" size:24]
#define REPOSITORIES_FONT_COLOR      [UIColor colorWithRed:.44 green:.44 blue:.44 alpha:1.00]

#define DONE_FONT            [UIFont fontWithName:@"ProximaNova-Light" size:13]
#define DONE_FONT_COLOR      [UIColor whiteColor]

@implementation BCRepositoryView

#pragma mark -
#pragma mark LifeCycles

- (id)init {
    self = [super init];
    if ( self ) {      
      UIImage *resizeableImage = [BACKGROUND_IMAGE stretchableImageWithLeftCapWidth:8 topCapHeight:44];
      _backgroundImageView = [[UIImageView alloc] initWithImage:resizeableImage];
      [self addSubview:_backgroundImageView];
      
      _repositoryLabel = [[UILabel alloc] init];
      _repositoryLabel.numberOfLines = 0;
      _repositoryLabel.font = REPOSITORIES_FONT;
      _repositoryLabel.textColor = REPOSITORIES_FONT_COLOR;
      _repositoryLabel.backgroundColor = [UIColor clearColor];
      [_repositoryLabel setText:@"Repositories"];
      [self addSubview:_repositoryLabel];
      
      _doneLabel = [[UILabel alloc] init];
      _doneLabel.numberOfLines = 0;
      _doneLabel.font = DONE_FONT;
      _doneLabel.textColor = DONE_FONT_COLOR;
      _doneLabel.backgroundColor = [UIColor clearColor];
      [_doneLabel setText:@"DONE"];
      [self addSubview:_doneLabel];
      
      _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
      [_tableView setAllowsMultipleSelection:YES];
      [self addSubview:_tableView];
      _tableView.backgroundColor = REPOSITORY_BG_COLOR;
      [self setBackgroundColor:REPOSITORY_BG_COLOR];
      _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect frame = CGRectMake(0, 0, self.frame.size.width, 50);
  if( !CGRectEqualToRect(_backgroundImageView.frame, frame)){
    _backgroundImageView.frame = frame;
  }
  
  frame = CGRectZero;
  frame.origin.y = TABLE_VIEW_OFFSET;
  frame.size = self.bounds.size;
  if ( !CGRectEqualToRect( _tableView.frame, frame ) ) {
    _tableView.frame = frame;
  }
  
  frame.size = [_repositoryLabel sizeThatFits:_backgroundImageView.frame.size];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.backgroundImageView.frame.size.height-frame.size.height)/2);
  if( !CGRectEqualToRect(_repositoryLabel.frame, frame)){
    _repositoryLabel.frame = frame;
  }
  
  frame.size = [_doneLabel sizeThatFits:_backgroundImageView.frame.size];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)-10, (self.backgroundImageView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_doneLabel.frame, frame)){
    _doneLabel.frame = frame;
  }
}

@end
