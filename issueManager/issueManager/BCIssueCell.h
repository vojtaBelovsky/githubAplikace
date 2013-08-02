//
//  BCIssueCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCIssue;
@class BCProfileIssue;

@interface BCIssueCell : UITableViewCell

@property BCProfileIssue* profileIssue;

+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView;

@end
