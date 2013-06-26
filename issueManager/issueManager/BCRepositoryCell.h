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

@property UIImageView *myImageView;
@property UILabel *myTextLabel;

+ (BCRepositoryCell *)createOrgOrUserRepositoryCellWithTableView:(UITableView *)tableView WithImg:(UIImage *)img;
+ (BCRepositoryCell *)createRepositoryCellWithTableView:(UITableView *)tableView;


@end
