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

@implementation BCSelectMilestoneCell

- (id)initWithMilestone:(BCMilestone *)milestone
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectMilestoneCellReuseIdentifier];
    if (self) {
        [self.textLabel setText:milestone.title];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
