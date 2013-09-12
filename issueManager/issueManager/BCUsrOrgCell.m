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
#define CORP_MASK             [UIImage imageNamed:@"corp-mask.png"]
#define AVATAR_OFFSET         (self.frame.size.width*0.1)
#define TEXT_OFFSET           (self.frame.size.width*0.1)
#define SEL_INDICATOR_OFFSET  (self.frame.size.width*0.1)
#define SIZE_OF_AVATAR        0.7

@implementation BCUsrOrgCell

+ (BCUsrOrgCell *)createOrgOrUserRepositoryCellWithTableView:(UITableView *)tableView {
  BCUsrOrgCell *cell = [tableView dequeueReusableCellWithIdentifier:createOrgOrMyRepositoryCellIdnetifier];
  if (! cell ) {
    cell = [[BCUsrOrgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createOrgOrMyRepositoryCellIdnetifier];
    
    cell.avatar = [[BCAvatarImgView alloc] init];
    [cell.avatar.maskImageView setImage:CORP_MASK];
    [cell addSubview:cell.avatar];
    
    cell.myTextLabel = [[UILabel alloc] init];
    cell.myTextLabel.backgroundColor = [UIColor clearColor];
    cell.myTextLabel.textColor = CELL_FONT_COLOR;
    cell.myTextLabel.font = CELL_FONT;
    cell.myTextLabel.numberOfLines = 0;
    [cell addSubview:cell.myTextLabel];
    
    cell.selectionIndicator = [[UIImageView alloc] initWithImage:SELECT_MEMBER_ARROW highlightedImage:SELECT_MEMBER_X];
    [cell addSubview:cell.selectionIndicator];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [cell.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
  }
  return cell;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = CGSizeMake(self.frame.size.height*SIZE_OF_AVATAR, self.frame.size.height*SIZE_OF_AVATAR);
  frame.origin = CGPointMake(AVATAR_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_avatar.frame, frame)) {
    _avatar.frame = frame;
  }
  
  frame.size = [_myTextLabel sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(AVATAR_OFFSET+_avatar.frame.size.width+TEXT_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_myTextLabel.frame, frame)) {
    _myTextLabel.frame = frame;
  }
  
  frame.size = [_selectionIndicator sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(self.frame.size.width-SEL_INDICATOR_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_selectionIndicator.frame, frame)) {
    _selectionIndicator.frame = frame;
  }
}

@end
