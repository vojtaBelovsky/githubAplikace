//
//  BCNoRepoCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 9/12/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCNoRepoCell : UITableViewCell

@property UILabel *myTextLabel;

+(BCNoRepoCell *)createNoRepoCellWithTableView:(UITableView *)tableView;

@end
