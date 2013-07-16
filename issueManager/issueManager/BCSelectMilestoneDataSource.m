//
//  BCSelectMilestoneDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectMilestoneDataSource.h"
#import "BCSelectMilestoneCell.h"
#import "BCMilestone.h"

@implementation BCSelectMilestoneDataSource

- (id)initWithMilestones:(NSArray *)milestones
{
    self = [super init];
    if (self) {
        _milestones = [[NSMutableArray alloc] initWithArray:milestones];
        [_milestones addObject:[[BCMilestone alloc] init]];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BCSelectMilestoneCell *cell;
    if([indexPath row] == ([_milestones count]-1) ){
        cell = [BCSelectMilestoneCell createDeleteCellWithTableView:tableView];
        cell.myTextLabel.text = NSLocalizedString(@"unselect milestone", @"");
    }else{
        cell = [BCSelectMilestoneCell createMilestoneCellWithTableView:tableView];
        BCMilestone *myMilestone = [_milestones objectAtIndex:indexPath.row];
        cell.myTextLabel.text = NSLocalizedString(myMilestone.title , @"");
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_isSelectedMilestone){
        return [_milestones count];
    }else{
        return [_milestones count]-1;
    }
}

@end
