//
//  BCIssueCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueCell.h"
#import "BCIssue.h"
#import "BCProfileIssue.h"

#define IssueCellReuseIdentifier @"IssueCellReuseIdentifier"
#define MilestoneCellReuseIdentifier @"MilestoneCellReuseIdentifier"

#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]

@implementation BCIssueCell

+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView {
  BCIssueCell *cell = [tableView dequeueReusableCellWithIdentifier:IssueCellReuseIdentifier];
  if ( !cell ) {
    cell = [[BCIssueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IssueCellReuseIdentifier];
    cell.profileIssue = [[BCProfileIssue alloc] init];
  }
  
  return cell;
}

+ (BCIssueCell *)createMilestoneCellWithTableView:(UITableView *)tableView {
  BCIssueCell *cell = [tableView dequeueReusableCellWithIdentifier:MilestoneCellReuseIdentifier];
  
  if ( !cell ) {
    cell = [[BCIssueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MilestoneCellReuseIdentifier];
  }
  
  return cell;
}

@end
