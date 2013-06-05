//
//  BCRepositoryCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCRepository;

@interface BCRepositoryCell : UITableViewCell

+ (BCRepositoryCell *)createOrgOrMyRepositoryCellWithTableView:(UITableView *)tableView;
+ (BCRepositoryCell *)createRepositoryCellWithTableView:(UITableView *)tableView;

@end
