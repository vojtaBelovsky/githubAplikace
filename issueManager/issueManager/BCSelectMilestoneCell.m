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
#define DeleteMilestoneCellReuseIdentifier @"DeleteMilestoneCellReuseIdentifier"


#define FONT_COLOR        [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define CELL_FONT              [UIFont fontWithName:@"ProximaNova-Regular" size:16]

#define CHECKBOX_OFFSET ( 40.0f )

#define NEW_ISSUE_SEPARATOR           [UIImage imageNamed:@"newIssueSeparator.png"]
#define NEW_ISSUE_CHECK_ON            [UIImage imageNamed:@"newIssueCheckOn.png"]
#define NEW_ISSUE_CHECK_OFF           [UIImage imageNamed:@"newIssueCheckOff.png"]

@implementation BCSelectMilestoneCell

+ (BCSelectMilestoneCell *)createMilestoneCellWithTableView:(UITableView *)tableView {
    BCSelectMilestoneCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectMilestoneCellReuseIdentifier];
    if ( !cell ) {
      cell = [[BCSelectMilestoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectMilestoneCellReuseIdentifier];
      CGRect frame;
      
      UIImageView *imageView;
      imageView = [[UIImageView alloc] initWithImage:NEW_ISSUE_CHECK_OFF highlightedImage:NEW_ISSUE_CHECK_ON];
      frame.origin = CGPointMake(cell.frame.size.width - (CHECKBOX_OFFSET+imageView.frame.size.width), (cell.frame.size.height-imageView.frame.size.height)/2);
      frame.size = imageView.frame.size;
      imageView.frame = frame;
      [cell addSubview:imageView];
      
      cell.myTextLabel = [[UILabel alloc] init];
      cell.myTextLabel.font = CELL_FONT;
      cell.myTextLabel.textColor = FONT_COLOR;
      frame.size = cell.frame.size;
      frame.size.width = frame.size.width - ((2*CHECKBOX_OFFSET)+imageView.frame.size.width);
      frame.origin = CGPointMake(15, (cell.frame.size.height-frame.size.height)/2);
      [cell.myTextLabel setFrame:frame];
      [cell.myTextLabel setBackgroundColor:[UIColor clearColor]];
      [cell addSubview:cell.myTextLabel];
      
      UIImage *image = [NEW_ISSUE_SEPARATOR stretchableImageWithLeftCapWidth:0 topCapHeight:1];
      frame.size = CGSizeMake(cell.frame.size.width, 1);
      frame.origin = CGPointMake(0, cell.frame.size.height-1);
      cell.separatorImgView = [[UIImageView alloc] initWithImage:image];
      cell.separatorImgView.frame = frame;
      [cell addSubview:cell.separatorImgView];
      
      [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
      cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
      [cell.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
    }
    return cell;
}

+ (BCSelectMilestoneCell *)createDeleteCellWithTableView:(UITableView *)tableView {
    BCSelectMilestoneCell *cell = [tableView dequeueReusableCellWithIdentifier:DeleteMilestoneCellReuseIdentifier];
    if ( !cell ) {
        cell = [[BCSelectMilestoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeleteMilestoneCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return cell;
}

@end
