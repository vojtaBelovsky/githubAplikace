//
//  BCCollaboratorsCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCAvatarImgView;

@interface BCCollaboratorsCell : UITableViewCell

@property BCAvatarImgView *avatarImgView;
@property UILabel *myTextLabel;
@property UIImageView *selectMemberArrow;
@property UIImageView *backgroundImgView;

+ (BCCollaboratorsCell *)createCollaboratorCell:(UITableView *)tableView;

@end
