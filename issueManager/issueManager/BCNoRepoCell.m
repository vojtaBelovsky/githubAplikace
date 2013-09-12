//
//  BCNoRepoCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 9/12/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCNoRepoCell.h"

@implementation BCNoRepoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
