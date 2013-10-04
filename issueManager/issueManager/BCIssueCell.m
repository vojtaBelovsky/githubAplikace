//
//  BCIssueCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueCell.h"
#import "BCSingleIssueView.h"
#import "BCIssue.h"
#import "BCNoIssuesView.h"

#define IssueCellReuseIdentifier      @"IssueCellReuseIdentifier"
#define NoIssuesCellReuseIdentifier   @"NoIssuesCellReuseIdentifier"
#define MilestoneCellReuseIdentifier  @"MilestoneCellReuseIdentifier"

#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]
#define NO_ISSUES_FRAME               CGRectMake(0, 0, 100, 

@implementation BCIssueCell

+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView offset:(CGFloat)offset font:(UIFont *)font{
  BCIssueCell *cell = [tableView dequeueReusableCellWithIdentifier:IssueCellReuseIdentifier];
  if ( !cell ) {
    cell = [[BCIssueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IssueCellReuseIdentifier];
    cell.issueView = [[BCSingleIssueView alloc] initWithTitleFont:font showAll:NO offset:offset];
    [cell addSubview:cell.issueView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  
  return cell;
}

+ (BCIssueCell *)createNoIssuesCellWithTableView:(UITableView *)tableView{
  
  BCIssueCell *cell = [tableView dequeueReusableCellWithIdentifier:NoIssuesCellReuseIdentifier];
  if ( !cell ) {
    cell = [[BCIssueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoIssuesCellReuseIdentifier];
    cell.noIssuesView = [[BCNoIssuesView alloc] init];
    [cell addSubview:cell.noIssuesView];
    cell.userInteractionEnabled = NO;
  }
  
  return cell;
}

+(CGFloat)heightOfCellWithIssue:(BCIssue *)issue width:(CGFloat)width titleFont:(UIFont *)font offset:(CGFloat)offset{
  if ([issue.title isEqualToString:NO_ISSUES]) {
    return 100;
  }
  return [BCSingleIssueView sizeOfSingleIssueViewWithIssue:issue width:width offset:offset titleFont:font showAll:NO].height;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  if(_issueView != nil){
    frame.size = CGSizeMake(ISSUE_WIDTH, [BCIssueCell heightOfCellWithIssue:self.issueView.issue width:ISSUE_WIDTH titleFont:CELL_TITLE_FONT offset:OFFSET]);
    frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.frame.size.height-frame.size.height)/2);
    if (!CGRectEqualToRect(_issueView.frame, frame)) {
      _issueView.frame = frame;
    }
  }
  
  if (_noIssuesView != nil) {
    if (!CGRectEqualToRect(_noIssuesView.frame, self.frame)) {
      _noIssuesView.frame = self.frame;
    }
  }
  
}

@end
