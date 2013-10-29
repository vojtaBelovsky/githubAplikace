//
//  BCSelectAssigneeCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeCell.h"
#import "BCUser.h"
#import "BCAvatarImgView.h"

#define SelectAssigneeCellReuseIdentifier @"SelectAssigneeCellReuseIdentifier"

#define FONT_COLOR        [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define CELL_FONT              [UIFont fontWithName:@"ProximaNova-Regular" size:16]

#define CHECKBOX_OFFSET           ( 20.0f )
#define CHECKBOX_WIDTH_AND_HEIGHT ( 0.3f )
#define AVATAR_WIDTH_AND_HEIGHT   ( 0.5f )
#define AVATAR_OFFSET             ( 10.0f )

#define NEW_ISSUE_SEPARATOR           [UIImage imageNamed:@"newIssueSeparator.png"]
#define NEW_ISSUE_CHECK_ON            [UIImage imageNamed:@"newIssueCheckOn.png"]
#define NEW_ISSUE_CHECK_OFF           [UIImage imageNamed:@"newIssueCheckOff.png"]

@implementation BCSelectAssigneeCell

+ (BCSelectAssigneeCell *)createAssigneCellWithTableView:(UITableView *)tableView {  
  BCSelectAssigneeCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectAssigneeCellReuseIdentifier];
  if ( !cell ) {
    cell = [[BCSelectAssigneeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectAssigneeCellReuseIdentifier];
    
    cell.checkboxImgView = [[UIImageView alloc] initWithImage:NEW_ISSUE_CHECK_OFF highlightedImage:NEW_ISSUE_CHECK_ON];
    [cell addSubview:cell.checkboxImgView];    
    
    cell.avatarImgView = [[BCAvatarImgView alloc] init];
    [cell addSubview:cell.avatarImgView];
    
    cell.myTextLabel = [[UILabel alloc] init];
    cell.myTextLabel.font = CELL_FONT;
    cell.myTextLabel.textColor = FONT_COLOR;
    [cell.myTextLabel setBackgroundColor:[UIColor clearColor]];
    [cell addSubview:cell.myTextLabel];
    
    UIImage *image = [NEW_ISSUE_SEPARATOR stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    cell.separatorImgView = [[UIImageView alloc] initWithImage:image];
    [cell addSubview:cell.separatorImgView];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [cell.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
  }
  return cell;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = CGSizeMake(self.frame.size.height*AVATAR_WIDTH_AND_HEIGHT, self.frame.size.height*AVATAR_WIDTH_AND_HEIGHT);
  frame.origin = CGPointMake(AVATAR_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_avatarImgView.frame, frame)) {
    _avatarImgView.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.height*CHECKBOX_WIDTH_AND_HEIGHT, self.frame.size.height*CHECKBOX_WIDTH_AND_HEIGHT);
  frame.origin = CGPointMake(self.frame.size.width-CHECKBOX_OFFSET-frame.size.width, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_checkboxImgView.frame, frame)) {
    _checkboxImgView.frame = frame;
  }
  
  frame.size = [_myTextLabel sizeThatFits:self.frame.size];
  frame.size.width = MIN(frame.size.width, self.frame.size.width-3*AVATAR_OFFSET-_avatarImgView.frame.size.width-CHECKBOX_OFFSET-_checkboxImgView.frame.size.width);
  frame.origin = CGPointMake(2*AVATAR_OFFSET+_avatarImgView.frame.size.width, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_myTextLabel.frame, frame)) {
    _myTextLabel.frame = frame;
  }
  
  frame.size = CGSizeMake(self.frame.size.width, 1);
  frame.origin = CGPointMake(0, self.frame.size.height-1);
  if (!CGRectEqualToRect(_separatorImgView.frame, frame)) {
    _separatorImgView.frame = frame;
  }
}

@end
