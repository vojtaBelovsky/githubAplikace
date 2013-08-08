//
//  BCIssueCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCIssue;
@class BCSingleIssueView;

@interface BCIssueCell : UITableViewCell

@property BCSingleIssueView* issueView;

+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView;

+(CGFloat)heightOfCellWithIssue:(BCIssue *)issue;

@end
