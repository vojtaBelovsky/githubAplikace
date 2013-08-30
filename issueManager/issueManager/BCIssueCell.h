//
//  BCIssueCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ISSUE_WIDTH         ( 300.0f )
#define OFFSET              ( 10.0f )
#define TITLE_FONT          [UIFont fontWithName:@"ProximaNova-Regular" size:16]

@class BCIssue;
@class BCSingleIssueView;

@interface BCIssueCell : UITableViewCell

@property BCSingleIssueView* issueView;
@property UIImageView *noIssuesImgView;

+ (BCIssueCell *)createIssueCellWithTableView:(UITableView *)tableView offset:(CGFloat)offset font:(UIFont *)font;

+(CGFloat)heightOfCellWithIssue:(BCIssue *)issue width:(CGFloat)width titleFont:(UIFont *)font offset:(CGFloat)offset;

+ (BCIssueCell *)createNoIssuesCellWithTableView:(UITableView *)tableView;

@end
