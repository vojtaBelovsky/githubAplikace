//
//  BCRepositoryCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryCell.h"
#import "BCRepository.h"

#define REPOSITORY_CHECKBOX_IMAGE     [UIImage imageNamed:@"checkbox.png"]
#define REPOSITORY_HL_CHECKBOX_IMAGE     [UIImage imageNamed:@"checkbox_checked.png"]

#define CHECKBOX_OFFSET         ( 50.0f )

#define createOrgOrMyRepositoryCellIdnetifier @"createOrgOrMyRepositoryCellIdnetifier"
#define createRepositoryCell @"createRepositoryCell"


@implementation BCRepositoryCell

+ (BCRepositoryCell *)createOrgOrUserRepositoryCellWithTableView:(UITableView *)tableView {
    BCRepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:createOrgOrMyRepositoryCellIdnetifier];
    if (! cell ) {
      cell = [[BCRepositoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createOrgOrMyRepositoryCellIdnetifier];
      cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

+ (BCRepositoryCell *)createRepositoryCellWithTableView:(UITableView *)tableView {
    BCRepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:createRepositoryCell];
    if (! cell ) {
      cell = [[BCRepositoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createRepositoryCell];
      cell.textLabel.textColor = [UIColor whiteColor];
      [cell.imageView setImage:REPOSITORY_CHECKBOX_IMAGE];
      [cell.imageView setHighlightedImage:REPOSITORY_HL_CHECKBOX_IMAGE];
      [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
      [cell.imageView setFrame:CGRectMake(10, 10, 10, 10)];
      [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
      cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
      [cell.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
    }
    return cell;
}

@end
