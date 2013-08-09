//
//  BCIssueCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueCell.h"
#import "BCSingleIssueView.h"

#define IssueCellReuseIdentifier @"IssueCellReuseIdentifier"
#define MilestoneCellReuseIdentifier @"MilestoneCellReuseIdentifier"

#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]

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

+(CGFloat)heightOfCellWithIssue:(BCIssue *)issue width:(CGFloat)width titleFont:(UIFont *)font offset:(CGFloat)offset{
  return [BCSingleIssueView sizeOfSingleIssueViewWithIssue:issue width:width offset:offset titleFont:font showAll:NO].height;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = CGSizeMake(ISSUE_WIDTH, [BCIssueCell heightOfCellWithIssue:self.issueView.issue width:ISSUE_WIDTH titleFont:TITLE_FONT offset:OFFSET]);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_issueView.frame, frame)) {
    _issueView.frame = frame;
  }
}

@end
