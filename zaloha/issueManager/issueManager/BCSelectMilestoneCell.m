//
//  BCSelectMilestoneCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectMilestoneCell.h"
#import "BCMilestone.h"

#define SelectMilestoneCellReuseIdentifier @"SelectMilestoneCellReuseIdentifier"


#define FONT_COLOR        [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define CELL_FONT              [UIFont fontWithName:@"ProximaNova-Regular" size:16]

#define CHECKBOX_OFFSET           ( 20.0f )
#define CHECKBOX_WIDTH_AND_HEIGHT ( 0.4f )
#define TEXT_OFFSET               ( 10.0f )

#define NEW_ISSUE_SEPARATOR           [UIImage imageNamed:@"newIssueSeparator.png"]
#define NEW_ISSUE_CHECK_ON            [UIImage imageNamed:@"newIssueCheckOn.png"]
#define NEW_ISSUE_CHECK_OFF           [UIImage imageNamed:@"newIssueCheckOff.png"]

@implementation BCSelectMilestoneCell

+ (BCSelectMilestoneCell *)createMilestoneCellWithTableView:(UITableView *)tableView {
    BCSelectMilestoneCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectMilestoneCellReuseIdentifier];
    if ( !cell ) {
      cell = [[BCSelectMilestoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectMilestoneCellReuseIdentifier];
      
      cell.checkboxImgView = [[UIImageView alloc] initWithImage:NEW_ISSUE_CHECK_OFF highlightedImage:NEW_ISSUE_CHECK_ON];
      [cell addSubview:cell.checkboxImgView];
      
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
  
  frame.size = CGSizeMake(self.frame.size.height*CHECKBOX_WIDTH_AND_HEIGHT, self.frame.size.height*CHECKBOX_WIDTH_AND_HEIGHT);
  frame.origin = CGPointMake(self.frame.size.width-CHECKBOX_OFFSET-frame.size.width, (self.frame.size.height-frame.size.height)/2);
  if (!CGRectEqualToRect(_checkboxImgView.frame, frame)) {
    _checkboxImgView.frame = frame;
  }
  
  frame.size = [_myTextLabel sizeThatFits:self.frame.size];
  frame.size.width = MIN(frame.size.width, self.frame.size.width-2*TEXT_OFFSET-_checkboxImgView.frame.size.width-CHECKBOX_OFFSET);
  frame.origin = CGPointMake(TEXT_OFFSET, (self.frame.size.height-frame.size.height)/2);
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
