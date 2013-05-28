//
//  BCIssueCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCIssue;

@interface BCIssueCell : UITableViewCell

- (id)initWithIssue:(BCIssue *)issue;
+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView;

@end
