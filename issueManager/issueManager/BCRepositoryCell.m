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
#define USR_OR_ORG_SELECTION_IMAGE     [UIImage imageNamed:@"selectMemberArrowOff.png"]
#define USR_OR_ORG_SELECTION_HL_IMAGE     [UIImage imageNamed:@"selectMemberXOff.png"]
#define USR_OR_ORG_IMG_WIDTH_AND_HEIGHT 18


#define CELL_FONT_COLOR [UIColor whiteColor]
#define CELL_FONT       [UIFont fontWithName:@"ProximaNova-Regular" size:13]

#define CHECKBOX_OFFSET         ( 50.0f )

#define createOrgOrMyRepositoryCellIdnetifier @"createOrgOrMyRepositoryCellIdnetifier"
#define createRepositoryCell @"createRepositoryCell"

#define CORP_MASK           [UIImage imageNamed:@"corp-mask.png"]

#define AVATAR_WIDTH          ( 30.0f )
#define AVATAR_HEIGHT         ( 30.0f )
#define AVATAR_LEFT_OFFSET    ( 15.0f )
#define AVATAR_TOP_OFFSET     ( 5.0f )

#define AVATAR_RECT CGRectMake(AVATAR_LEFT_OFFSET, AVATAR_TOP_OFFSET, AVATAR_WIDTH, AVATAR_HEIGHT)


@implementation BCRepositoryCell

+ (BCRepositoryCell *)createOrgOrUserRepositoryCellWithTableView:(UITableView *)tableView WithImg:(UIImage *)img{
    BCRepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:createOrgOrMyRepositoryCellIdnetifier];
    if (! cell ) {
      cell = [[BCRepositoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createOrgOrMyRepositoryCellIdnetifier];
      
      cell.myTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 250, 20)];
      cell.myTextLabel.backgroundColor = [UIColor clearColor];
      cell.myTextLabel.textColor = CELL_FONT_COLOR;
      cell.myTextLabel.font = CELL_FONT;
      [cell addSubview:cell.myTextLabel];
      
      
      [cell setMyImageView:[[UIImageView alloc] initWithImage:img]];
      [[cell myImageView] setFrame:AVATAR_RECT];
      [cell addSubview:cell.myImageView];
      
      [cell setCorpMask:[[UIImageView alloc] initWithImage:CORP_MASK]];
      [cell.corpMask setFrame:AVATAR_RECT];
      [cell addSubview:cell.corpMask];
        
      [cell setSelectUsrOrOrgImgView:[[UIImageView alloc] initWithImage:USR_OR_ORG_SELECTION_IMAGE highlightedImage:USR_OR_ORG_SELECTION_HL_IMAGE]];
      [[cell selectUsrOrOrgImgView] setFrame:CGRectMake((cell.frame.size.width-USR_OR_ORG_IMG_WIDTH_AND_HEIGHT)-15, (cell.frame.size.height-USR_OR_ORG_IMG_WIDTH_AND_HEIGHT)/2, USR_OR_ORG_IMG_WIDTH_AND_HEIGHT, USR_OR_ORG_IMG_WIDTH_AND_HEIGHT)];
      [cell addSubview:cell.selectUsrOrOrgImgView];
      
      [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
      cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
      [cell.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
    }
    return cell;
}

+ (BCRepositoryCell *)createRepositoryCellWithTableView:(UITableView *)tableView {
    BCRepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:createRepositoryCell];
    if (! cell ) {
      cell = [[BCRepositoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createRepositoryCell];
      cell.myTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 210, 20)];
      cell.myTextLabel.backgroundColor = [UIColor clearColor];
      cell.myTextLabel.textColor = CELL_FONT_COLOR;
      cell.myTextLabel.font = CELL_FONT;
      [cell addSubview:cell.myTextLabel];
      
      [cell setMyImageView:[[UIImageView alloc] initWithImage:REPOSITORY_CHECKBOX_IMAGE highlightedImage:REPOSITORY_HL_CHECKBOX_IMAGE]];
      [[cell myImageView] setFrame:CGRectMake(30, (cell.frame.size.height-cell.myImageView.frame.size.height)/2, cell.myImageView.frame.size.width, cell.myImageView.frame.size.height)];
      [cell addSubview:cell.myImageView];
      
      [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
      cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
      [cell.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
    }
    return cell;
}

@end
