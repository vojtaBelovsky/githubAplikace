//
//  BCSelectLabelsCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCLabel;
@class BCLabelColorImgView;

@interface BCSelectLabelsCell : UITableViewCell

@property UIImageView *separatorImgView;
@property BCLabelColorImgView *BCLabelColorImgView;
@property UILabel *myTextLabel;
@property UIImageView *checkboxImgView;

+(BCSelectLabelsCell *)createLabelCellWithTableView:(UITableView *)tableView;

@end
