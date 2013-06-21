//
//  BCRepositoryCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryCell.h"
#import "BCRepository.h"

#define createOrgOrMyRepositoryCellIdnetifier @"createOrgOrMyRepositoryCellIdnetifier"
#define createRepositoryCell @"createRepositoryCell"


@implementation BCRepositoryCell

+ (BCRepositoryCell *)createOrgOrUserRepositoryCellWithTableView:(UITableView *)tableView {
    BCRepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:createOrgOrMyRepositoryCellIdnetifier];
    if (! cell ) {
      cell = [[BCRepositoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createOrgOrMyRepositoryCellIdnetifier];
      cell.backgroundView.backgroundColor = [UIColor blackColor];
      cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

+ (BCRepositoryCell *)createRepositoryCellWithTableView:(UITableView *)tableView {
    BCRepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:createRepositoryCell];
    if (! cell ) {
      cell = [[BCRepositoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createRepositoryCell];
      cell.backgroundColor = [UIColor blackColor];
      cell.textLabel.textColor = [UIColor grayColor];
      [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
      [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    return cell;
}

@end
