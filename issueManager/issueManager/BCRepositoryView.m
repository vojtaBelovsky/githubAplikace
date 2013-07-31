//
//  BCRepositoryView.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/28/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryView.h"

#define REPOSITORY_BG_COLOR             [UIColor colorWithRed:.11 green:.11 blue:.11 alpha:1.00]
#define BACKGROUND_IMAGE                [UIImage imageNamed:@"repositories_gradient.png"]

#define TABLE_VIEW_OFFSET               ( 50.0f )

#define REPOSITORIES_FONT               [UIFont fontWithName:@"ProximaNova-Light" size:24]
#define REPOSITORIES_FONT_COLOR         [UIColor colorWithRed:.44 green:.44 blue:.44 alpha:1.00]
#define REPOSITORIES_SHADOW_FONT_COLOR  [UIColor blackColor]

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
    
    _repositoryLabelShadow = [[UILabel alloc] init];
    _repositoryLabelShadow.numberOfLines = 0;
    _repositoryLabelShadow.font = REPOSITORIES_FONT;
    _repositoryLabelShadow.textColor = REPOSITORIES_SHADOW_FONT_COLOR;
    _repositoryLabelShadow.backgroundColor = [UIColor clearColor];
    [_repositoryLabelShadow setText:@"Repositories"];
    [self addSubview:_repositoryLabelShadow];
    
    _repositoryLabel = [[UILabel alloc] init];
    _repositoryLabel.numberOfLines = 0;
    _repositoryLabel.font = REPOSITORIES_FONT;
    _repositoryLabel.textColor = REPOSITORIES_FONT_COLOR;
    _repositoryLabel.backgroundColor = [UIColor clearColor];
    [_repositoryLabel setText:@"Repositories"];
    [self addSubview:_repositoryLabel];
    
    _doneButton = [[UIButton alloc] init];
    _doneButton.titleLabel.numberOfLines = 0;
    _doneButton.titleLabel.font = DONE_FONT;
    [_doneButton setTitleColor:DONE_FONT_COLOR forState:UIControlStateNormal];
    _doneButton.titleLabel.backgroundColor = [UIColor clearColor];
    [_doneButton setTitle:@"DONE" forState:UIControlStateNormal];
    [_doneButton setEnabled:YES];
    [self addSubview:_doneButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setAllowsMultipleSelection:YES];
    _tableView.backgroundColor = REPOSITORY_BG_COLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    [self setBackgroundColor:REPOSITORY_BG_COLOR];
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
  
  frame.size = [_repositoryLabelShadow sizeThatFits:_backgroundImageView.frame.size];
  frame.origin = CGPointMake(((self.frame.size.width-frame.size.width)/2)+1, ((self.backgroundImageView.frame.size.height-frame.size.height)/2)+1);
  if( !CGRectEqualToRect(_repositoryLabelShadow.frame, frame)){
    _repositoryLabelShadow.frame = frame;
  }
  
  frame.size = [_repositoryLabel sizeThatFits:_backgroundImageView.frame.size];
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.backgroundImageView.frame.size.height-frame.size.height)/2);
  if( !CGRectEqualToRect(_repositoryLabel.frame, frame)){
    _repositoryLabel.frame = frame;
  }
  
  frame.size = [_doneButton sizeThatFits:_backgroundImageView.frame.size];
  frame.origin = CGPointMake((self.backgroundImageView.frame.size.width-frame.size.width)-10, (self.backgroundImageView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_doneButton.frame, frame)){
    _doneButton.frame = frame;
  }
}

@end
