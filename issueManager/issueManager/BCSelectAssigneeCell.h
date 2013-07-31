//
//  BCSelectAssigneeCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCUser;
@class BCAvatarImgView;

@interface BCSelectAssigneeCell : UITableViewCell

@property UIImageView *separatorImgView;
@property BCAvatarImgView *avatarImgView;
@property UILabel *myTextLabel;
@property UIImageView *checkboxImgView;



+ (BCSelectAssigneeCell *)createAssigneCellWithTableView:(UITableView *)tableView;
@end
