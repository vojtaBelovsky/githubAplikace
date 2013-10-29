//
//  BCCollaboratorsView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCCollaboratorsView.h"

#define REPOSITORY_BG_COLOR             [UIColor colorWithRed:.11 green:.11 blue:.11 alpha:1.00]
#define BACKGROUND_IMAGE                [UIImage imageNamed:@"repositories_gradient.png"]

@implementation BCCollaboratorsView

- (id)init
{
  self = [super init];
  if (self) {
    UIImage *resizeableImage = [BACKGROUND_IMAGE stretchableImageWithLeftCapWidth:8 topCapHeight:88];
    _backgroundImageView = [[UIImageView alloc] initWithImage:resizeableImage];
    [self addSubview:_backgroundImageView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setAllowsMultipleSelection:YES];
    _tableView.backgroundColor = REPOSITORY_BG_COLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    [self setBackgroundColor:REPOSITORY_BG_COLOR];

  }
  return self;
}

-(void)layoutSubviews{
  CGRect frame = self.frame;
  if (!CGRectEqualToRect(_tableView.frame, frame)) {
    _tableView.frame = frame;
  }
  if (!CGRectEqualToRect(_backgroundImageView.frame, frame)) {
    _backgroundImageView.frame = frame;
  }
}

@end
