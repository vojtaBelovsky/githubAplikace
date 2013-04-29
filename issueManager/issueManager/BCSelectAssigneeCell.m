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

@implementation BCSelectAssigneeCell

- (id)initWithAssignee:(BCUser *)assignee
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectAssigneeCellReuseIdentifier];
    if (self) {
        [self.textLabel setText:assignee.userLogin];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
