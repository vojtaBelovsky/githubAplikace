//
//  BCIssueView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueView.h"

@implementation BCIssueView

-(id)init{
    self = [super init];
    if(self){
        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = CGRectZero;
    frame.size = self.bounds.size;
    if(!CGRectEqualToRect(frame, _tableView.frame)){
        _tableView.frame = frame;
    }
}

@end
