//
//  BCIssueCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueCell.h"
#import "BCIssue.h"

#define IssueCellReuseIdentifier @"IssueCellReuseIdentifier"

@implementation BCIssueCell

- (id)initWithIssue:(BCIssue *)issue
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IssueCellReuseIdentifier];
    if (self) {
        [self.textLabel setText:issue.title];
        [self.textLabel setFont:[UIFont fontWithName:@"arial" size:15]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
