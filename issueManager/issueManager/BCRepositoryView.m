//
//  BCRepositoryView.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/28/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryView.h"

@implementation BCRepositoryView

#pragma mark -
#pragma mark LifeCycles

- (id)init {
    self = [super init];
    if ( self ) {
      _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
      [_tableView setAllowsMultipleSelection:YES];
      [self addSubview:_tableView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = CGRectZero;
    frame.size = self.bounds.size;
    if ( !CGRectEqualToRect( _tableView.frame, frame ) ) {
        _tableView.frame = frame;
    }
}

@end
