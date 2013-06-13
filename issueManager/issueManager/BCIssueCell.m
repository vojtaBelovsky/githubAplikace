//
//  BCIssueCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueCell.h"
#import "BCIssue.h"

#define IssueCellReuseIdentifier @"IssueCellReuseIdentifier"

@implementation BCIssueCell

+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView {
  BCIssueCell *cell = nil;
  if ( !cell ) {
    cell = [[BCIssueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IssueCellReuseIdentifier];
  }
  return cell;
}

+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView {
    BCIssueCell *cell = [tableView dequeueReusableCellWithIdentifier:IssueCellReuseIdentifier];
    if ( !cell ) {
        cell = [[BCIssueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IssueCellReuseIdentifier];
    }
    return cell;
}

@end
