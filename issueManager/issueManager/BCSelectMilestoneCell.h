//
//  BCSelectMilestoneCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCMilestone;

@interface BCSelectMilestoneCell : UITableViewCell
@property UIImageView *separatorImgView;
@property UILabel *myTextLabel;

+ (BCSelectMilestoneCell *)createMilestoneCellWithTableView:(UITableView *)tableView;
+ (BCSelectMilestoneCell *)createDeleteCellWithTableView:(UITableView *)tableView;

@end
