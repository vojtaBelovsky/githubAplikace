//
//  BCSelectLabelsCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectLabelsCell.h"
#import "BCLabel.h"

#define SelectLabelsCellReuseIdentifier @"SelectLabelsCellReuseIdentifier"

@implementation BCSelectLabelsCell

- (id)initWithLabel:(BCLabel *)label
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectLabelsCellReuseIdentifier];
    if (self) {
        [self.textLabel setText:label.name];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
