//
//  BCRepoCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 9/12/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCRepoCell : UITableViewCell
@property UIImageView *checkbox;
@property UILabel *myTextLabel;

+ (BCRepoCell *)createRepositoryCellWithTableView:(UITableView *)tableView;

@end
