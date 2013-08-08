//
//  BCIssueCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueCell.h"
#import "BCIssue.h"
#import "BCSingleIssueView.h"
#import "BCLabel.h"
#import "BCIssueTitleLabel.h"
#import "BCLabelView.h"
#import "BCIssueBodyLabel.h"

#define IssueCellReuseIdentifier @"IssueCellReuseIdentifier"
#define MilestoneCellReuseIdentifier @"MilestoneCellReuseIdentifier"

#define INNER_OFFSET         ( 2.0f )
#define OUTER_OFFSET         ( 10.0f )
#define MAX_TITLE_WIDTH      ( 280.0f )

#define BACKGROUND_IMAGE_FOR_FORM     [UIImage imageNamed:@"profileIssueBackground.png"]
#define PROFILE_ISSUE_WIDTH           ( 300.0f )
#define TITLE_FONT                    [UIFont fontWithName:@"ProximaNova-Regular" size:16]

@implementation BCIssueCell

+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView {
  BCIssueCell *cell = [tableView dequeueReusableCellWithIdentifier:IssueCellReuseIdentifier];
  if ( !cell ) {
    cell = [[BCIssueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IssueCellReuseIdentifier];
    cell.issueView = [[BCSingleIssueView alloc] initWithTitleFont:TITLE_FONT showAll:NO];
    [cell addSubview:cell.issueView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  
  return cell;
}

+(CGFloat)heightOfCellWithIssue:(BCIssue *)issue{
  CGSize sizeOfCurrentIssueTitle = [BCIssueTitleLabel sizeOfLabelWithText:issue.title withFont:TITLE_FONT];
  CGSize sizeOfCurrentLabel;
  int width = 281;
  int heightOfLabels = 0;
  int numberOfLines = 0;
  for (BCLabel *object in issue.labels) {
    sizeOfCurrentLabel = [BCLabelView sizeOfLabelWithText:object.name];
    if ((width+sizeOfCurrentLabel.width)>MAX_TITLE_WIDTH) {
      numberOfLines++;
      heightOfLabels += sizeOfCurrentLabel.height;
      width = 0;
    }
    width += sizeOfCurrentLabel.width;
  }
  
  return (sizeOfCurrentIssueTitle.height+(2*OUTER_OFFSET)+heightOfLabels+(numberOfLines*INNER_OFFSET));
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = CGSizeMake(PROFILE_ISSUE_WIDTH, [BCIssueCell heightOfCellWithIssue:_issueView.issue]);
  frame.origin = CGPointMake((self.frame.size.width-frame.size.width)/2, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_issueView.frame, frame)) {
    _issueView.frame = frame;
  }
}

@end
