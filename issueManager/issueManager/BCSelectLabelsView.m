//
//  BCSelectLabelsView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectLabelsView.h"

@implementation BCSelectLabelsView

- (id)init
{
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc] init];
        [_tableView setAllowsMultipleSelection:YES];
        [self addSubview:_tableView];
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = CGRectZero;
    frame.size = self.bounds.size;
    if(!CGRectEqualToRect(frame, _tableView.frame)){
        _tableView.frame = frame;
    }
}

@end
