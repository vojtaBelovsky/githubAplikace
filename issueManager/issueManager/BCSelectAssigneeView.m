//
//  BCSelectAssigneeView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeView.h"

@implementation BCSelectAssigneeView

- (id)init
{
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc] init];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
