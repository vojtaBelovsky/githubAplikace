//
//  BCRepositoryCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryCell.h"
#import "BCRepository.h"

#define BCRepositoryCellIdentifier @"BCRepositoryCellIdentifier"

@implementation BCRepositoryCell

- (id)initWithRepository:(BCRepository *)repository
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BCRepositoryCellIdentifier];
    if (self) {
        [self.textLabel setFont:[UIFont fontWithName:@"arial" size:15]];
        [self.textLabel setText:repository.name];
        
        
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
