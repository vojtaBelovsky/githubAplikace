//
//  BCSelectAssigneeCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeCell.h"
#import "BCUser.h"

#define SelectAssigneeCellReuseIdentifier @"SelectAssigneeCellReuseIdentifier"
#define DeleteAssigneeCellReuseIdentifier @"DeleteAssigneeCellReuseIdentifier"

@implementation BCSelectAssigneeCell

+ (BCSelectAssigneeCell *)createAssigneCellWithTableView:(UITableView *)tableView {
    BCSelectAssigneeCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectAssigneeCellReuseIdentifier];
    if ( !cell ) {
        cell = [[BCSelectAssigneeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectAssigneeCellReuseIdentifier];
    }
    
    return cell;
}

+ (BCSelectAssigneeCell *)createDeleteCellWithTableView:(UITableView *)tableView {
    BCSelectAssigneeCell *cell = [tableView dequeueReusableCellWithIdentifier:DeleteAssigneeCellReuseIdentifier];
    if ( !cell ) {
        cell = [[BCSelectAssigneeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeleteAssigneeCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    return cell;
}

@end
