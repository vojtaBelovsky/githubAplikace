//
//  BCUsrOrgCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 9/12/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCUsrOrgCell.h"
#import "BCAvatarImgView.h"

#define createOrgOrMyRepositoryCellIdnetifier @"createOrgOrMyRepositoryCellIdnetifier"

#define CELL_FONT_COLOR       [UIColor whiteColor]
#define CELL_FONT             [UIFont fontWithName:@"ProximaNova-Regular" size:13]
#define SELECT_MEMBER_ARROW   [UIImage imageNamed:@"selectMemberArrowOff.png"]
#define SELECT_MEMBER_X       [UIImage imageNamed:@"selectMemberXOff.png"]

@implementation BCUsrOrgCell

+ (BCUsrOrgCell *)createOrgOrUserRepositoryCellWithTableView:(UITableView *)tableView WithImg:(UIImage *)img{
  BCUsrOrgCell *cell = [tableView dequeueReusableCellWithIdentifier:createOrgOrMyRepositoryCellIdnetifier];
  if (! cell ) {
    cell = [[BCUsrOrgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createOrgOrMyRepositoryCellIdnetifier];
    
    cell.myTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 250, 20)];
    cell.myTextLabel.backgroundColor = [UIColor clearColor];
    cell.myTextLabel.textColor = CELL_FONT_COLOR;
    cell.myTextLabel.font = CELL_FONT;
    [cell addSubview:cell.myTextLabel];
    
    
    cell.avatar = [[BCAvatarImgView alloc] init];
    [cell addSubview:cell.avatar];
    
    [cell setSelectUsrOrOrgImgView:[[UIImageView alloc] initWithImage:USR_OR_ORG_SELECTION_IMAGE highlightedImage:USR_OR_ORG_SELECTION_HL_IMAGE]];
    [[cell selectUsrOrOrgImgView] setFrame:CGRectMake((cell.frame.size.width-USR_OR_ORG_IMG_WIDTH_AND_HEIGHT)-15, (cell.frame.size.height-USR_OR_ORG_IMG_WIDTH_AND_HEIGHT)/2, USR_OR_ORG_IMG_WIDTH_AND_HEIGHT, USR_OR_ORG_IMG_WIDTH_AND_HEIGHT)];
    [cell addSubview:cell.selectUsrOrOrgImgView];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [cell.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
  }
  return cell;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  
}

@end
