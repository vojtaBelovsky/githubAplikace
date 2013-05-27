//
//  BCSelectMilestoneCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectMilestoneCell.h"
#import "BCMilestone.h"

#define SelectMilestoneCellReuseIdentifier @"SelectMilestoneCellReuseIdentifier"
#define DeleteMilestoneCellReuseIdentifier @"DeleteMilestoneCellReuseIdentifier"

@implementation BCSelectMilestoneCell

+ (BCSelectMilestoneCell *)createMilestoneCellWithTableView:(UITableView *)tableView {
    BCSelectMilestoneCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectMilestoneCellReuseIdentifier];
    if ( !cell ) {
        cell = [[BCSelectMilestoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectMilestoneCellReuseIdentifier];
    }
    return cell;
}

+ (BCSelectMilestoneCell *)createDeleteCellWithTableView:(UITableView *)tableView {
    BCSelectMilestoneCell *cell = [tableView dequeueReusableCellWithIdentifier:DeleteMilestoneCellReuseIdentifier];
    if ( !cell ) {
        cell = [[BCSelectMilestoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeleteMilestoneCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return cell;
}

@end
