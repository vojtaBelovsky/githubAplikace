//
//  BCIssueCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ISSUE_WIDTH         ( 300.0f )
#define OFFSET              ( 13.0f )
#define CELL_TITLE_FONT               [UIFont fontWithName:@"ProximaNova-Regular" size:14]

@class BCIssue;
@class BCSingleIssueView;
@class BCNoIssuesView;

@interface BCIssueCell : UITableViewCell

@property BCSingleIssueView* issueView;
@property BCNoIssuesView *noIssuesView;

+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView offset:(CGFloat)offset font:(UIFont *)font;

+(CGFloat)heightOfCellWithIssue:(BCIssue *)issue width:(CGFloat)width titleFont:(UIFont *)font offset:(CGFloat)offset;

+ (BCIssueCell *)createNoIssuesCellWithTableView:(UITableView *)tableView;

@end
