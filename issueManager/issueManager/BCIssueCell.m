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
#define PROFILE_ISSUE_WIDTH           ( 300.0f )
#define TITLE_FONT                    [UIFont fontWithName:@"ProximaNova-Regular" size:16]

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
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = CGSizeMake(PROFILE_ISSUE_WIDTH, [BCIssue heightOfIssueInProfileWithIssue:_profileIssue.issue withFont:TITLE_FONT]);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_profileIssue.frame, frame)) {
    _profileIssue.frame = frame;
  }
}

@end
