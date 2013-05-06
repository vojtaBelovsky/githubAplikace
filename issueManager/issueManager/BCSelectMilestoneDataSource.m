//
//  BCSelectMilestoneDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectMilestoneDataSource.h"
#import "BCSelectMilestoneCell.h"

@implementation BCSelectMilestoneDataSource

- (id)initWithMilestones:(NSArray *)milestones
{
    self = [super init];
    if (self) {
        _milestones = milestones;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[BCSelectMilestoneCell alloc] initWithMilestone:[_milestones objectAtIndex:indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_milestones count];
}

@end
