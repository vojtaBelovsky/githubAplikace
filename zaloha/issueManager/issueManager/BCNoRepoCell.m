//
//  BCNoRepoCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 9/12/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCNoRepoCell.h"

#define noRepoCellReuseIdentifier @"noRepoCellReuseIdentifier"

#define CELL_FONT                     [UIFont fontWithName:@"ProximaNova-Regular" size:13]
#define CELL_FONT_COLOR               [UIColor whiteColor]
#define TEXT_OFFSET                   (self.frame.size.width*0.3)

@implementation BCNoRepoCell

+(BCNoRepoCell *)createNoRepoCellWithTableView:(UITableView *)tableView{
  BCNoRepoCell *cell = [tableView dequeueReusableCellWithIdentifier:noRepoCellReuseIdentifier];
  
  if (!cell) {
    cell = [[BCNoRepoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noRepoCellReuseIdentifier];
    cell.userInteractionEnabled = NO;
    
    cell.myTextLabel = [[UILabel alloc] init];
    cell.myTextLabel.backgroundColor = [UIColor clearColor];
    cell.myTextLabel.textColor = CELL_FONT_COLOR;
    cell.myTextLabel.font = CELL_FONT;
    cell.myTextLabel.numberOfLines = 0;
    [cell addSubview:cell.myTextLabel];
  }
  return cell;
}

-(void)layoutSubviews{
  [super layoutSubviews];
  CGRect frame;
  
  frame.size = [_myTextLabel sizeThatFits:self.frame.size];
  frame.origin = CGPointMake(TEXT_OFFSET, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_myTextLabel.frame, frame)) {
    _myTextLabel.frame = frame;
  }
}

@end