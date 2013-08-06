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
    [cell addSubview:cell.profileIssue];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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

-(void)layoutSubviews{
  CGRect frame;
  
  frame.size = _profileIssue.frame.size;
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_profileIssue.frame, frame)) {
    _profileIssue.frame = frame;
  }
}

@end
