//
//  BCUsrOrgCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 9/12/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCAvatarImgView;

@interface BCUsrOrgCell : UITableViewCell

@property UILabel *myTextLabel;
@property BCAvatarImgView *avatar;
@property UIImageView *selectionIndicator;

+ (BCUsrOrgCell *)createOrgOrUserRepositoryCellWithTableView:(UITableView *)tableView;

@end
