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
@property UIImageView *corpMask;
@property UILabel *myTextLabel;
@property UIImageView *selectUsrOrOrgImgView;

+ (BCRepositoryCell *)createOrgOrUserRepositoryCellWithTableView:(UITableView *)tableView WithImg:(UIImage *)img;
+ (BCRepositoryCell *)createRepositoryCellWithTableView:(UITableView *)tableView;
+(BCRepositoryCell *)createNoRepoCellWithTableView:(UITableView *)tableView;

@end
