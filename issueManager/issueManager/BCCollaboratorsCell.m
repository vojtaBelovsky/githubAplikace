//
//  BCCollaboratorsCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCCollaboratorsCell.h"
#import "BCAvatarImgView.h"

#define createCollaboratorCellReuseIdentifier @"createCollaboratorCellReuseIdentifier"

#define SELECT_MEMBER_ARROW     [UIImage imageNamed:@"selectMemberArrowOff.png"]
#define SELECT_MEMBER_ARROW_HL  [UIImage imageNamed:@"selectMemberArrowOn.png"]
#define MEMBER_SELECTED         [UIImage imageNamed:@"selectMemberSelected.png"]
#define MEMBER_NOT_SELECTED     [UIImage imageNamed:@"selectMemberNotSelected.png"]

#define CELL_FONT_COLOR         [UIColor whiteColor]
#define CELL_FONT               [UIFont fontWithName:@"ProximaNova-Regular" size:13]
#define CORP_MASK               [UIImage imageNamed:@"user-mask.png"]
#define CORP_MASK_SELECTED      [UIImage imageNamed:@"userMaskSelected"]

#define AVATAR_WIDTH            ( 30.0f )
#define AVATAR_HEIGHT           ( 30.0f )
#define AVATAR_LEFT_OFFSET      ( 20.0f )
#define CELL_HEIGHT             ( 60.0f )
#define USER_NAME_OFFSET        ( 10.0f )
#define ARROW_RIGHT_OFFSET      ( 18.0f )

@implementation BCCollaboratorsCell

+ (BCCollaboratorsCell *)createCollaboratorCell:(UITableView *)tableView{
  BCCollaboratorsCell *cell = [tableView dequeueReusableCellWithIdentifier:createCollaboratorCellReuseIdentifier];
  if (! cell ) {
    cell = [[BCCollaboratorsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createCollaboratorCellReuseIdentifier];
    
    UIImage *stretchableImage = [MEMBER_NOT_SELECTED stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    UIImage *stretchableImageHL = [MEMBER_SELECTED stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    cell.backgroundImgView = [[UIImageView alloc] initWithImage:stretchableImage highlightedImage:stretchableImageHL];
    [cell addSubview:cell.backgroundImgView];
    
    cell.myTextLabel = [[UILabel alloc] init];
    cell.myTextLabel.backgroundColor = [UIColor clearColor];
    cell.myTextLabel.textColor = CELL_FONT_COLOR;
    cell.myTextLabel.font = CELL_FONT;
    [cell addSubview:cell.myTextLabel];
    
    cell.avatarImgView = [[BCAvatarImgView alloc] init];
    [cell.avatarImgView.maskImageView setImage:CORP_MASK];
    [cell.avatarImgView.maskImageView setHighlightedImage:CORP_MASK_SELECTED];
    [cell addSubview:cell.avatarImgView];
    
    cell.selectMemberArrow = [[UIImageView alloc] initWithImage:SELECT_MEMBER_ARROW highlightedImage:SELECT_MEMBER_ARROW_HL];
    [cell addSubview:cell.selectMemberArrow];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [cell.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
  }
  return cell;
}

-(void)layoutSubviews{
  CGRect frame = CGRectZero;
  
  frame.size = CGSizeMake(AVATAR_WIDTH, AVATAR_HEIGHT);
  frame.origin = CGPointMake(AVATAR_LEFT_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_avatarImgView.frame, frame)) {
    _avatarImgView.frame = frame;
  }
  
  frame.size = [_myTextLabel sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(AVATAR_LEFT_OFFSET+_avatarImgView.frame.size.width+USER_NAME_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_myTextLabel.frame, frame)) {
    _myTextLabel.frame = frame;
  }
  
  frame.size = [_selectMemberArrow sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(self.frame.size.width-_selectMemberArrow.frame.size.width-ARROW_RIGHT_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_selectMemberArrow.frame, frame)) {
    _selectMemberArrow.frame = frame;
  }
  
  frame.size = self.frame.size;
  frame.origin = CGPointZero;
  if (!CGRectEqualToRect(_backgroundImgView.frame, frame)) {
    _backgroundImgView.frame = frame;
  }
}

@end
