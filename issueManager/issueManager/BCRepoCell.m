//
//  BCRepoCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 9/12/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepoCell.h"

#define createRepositoryCell @"createRepositoryCell"

#define CELL_FONT_COLOR               [UIColor whiteColor]
#define CELL_FONT                     [UIFont fontWithName:@"ProximaNova-Regular" size:13]
#define REPOSITORY_CHECKBOX_IMAGE     [UIImage imageNamed:@"checkbox.png"]
#define REPOSITORY_HL_CHECKBOX_IMAGE  [UIImage imageNamed:@"checkbox_checked.png"]
#define CHECKBOX_OFFSET               (self.frame.size.width*0.2)
#define TEXT_OFFSET                   (self.frame.size.width*0.1)
#define SIZE_OF_CHECHBOX              0.65

@implementation BCRepoCell

+ (BCRepoCell *)createRepositoryCellWithTableView:(UITableView *)tableView {
  BCRepoCell *cell = [tableView dequeueReusableCellWithIdentifier:createRepositoryCell];
  if (! cell ) {
    cell = [[BCRepoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createRepositoryCell];
    
    cell.myTextLabel = [[UILabel alloc] init];
    cell.myTextLabel.backgroundColor = [UIColor clearColor];
    cell.myTextLabel.textColor = CELL_FONT_COLOR;
    cell.myTextLabel.font = CELL_FONT;
    cell.myTextLabel.numberOfLines = 0;
    [cell addSubview:cell.myTextLabel];
    
    [cell setCheckbox:[[UIImageView alloc] initWithImage:REPOSITORY_CHECKBOX_IMAGE highlightedImage:REPOSITORY_HL_CHECKBOX_IMAGE]];
    [cell addSubview:cell.checkbox];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [cell.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
  }
  return cell;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = CGSizeMake(self.frame.size.height*SIZE_OF_CHECHBOX, self.frame.size.height*SIZE_OF_CHECHBOX);
  frame.origin = CGPointMake(CHECKBOX_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_checkbox.frame, frame)) {
    _checkbox.frame = frame;
  }
  
  frame.size = [_myTextLabel sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(CHECKBOX_OFFSET+_checkbox.frame.size.width+TEXT_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_myTextLabel.frame, frame)) {
    _myTextLabel.frame = frame;
  }
}

@end
