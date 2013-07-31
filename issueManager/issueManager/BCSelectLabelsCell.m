//
//  BCSelectLabelsCell.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectLabelsCell.h"
#import "BCLabel.h"
#import "BCLabelColorImgView.h"

#define SelectLabelsCellReuseIdentifier @"SelectLabelsCellReuseIdentifier"

#define SelectAssigneeCellReuseIdentifier @"SelectAssigneeCellReuseIdentifier"

#define FONT_COLOR        [UIColor colorWithRed:.56 green:.56 blue:.56 alpha:1.00]
#define CELL_FONT              [UIFont fontWithName:@"ProximaNova-Regular" size:16]

#define CHECKBOX_OFFSET ( 40.0f )
#define AVATAR_WIDTH    cell.BCLabelColorImgView.frame.size.width
#define AVATAR_HEIGHT   cell.BCLabelColorImgView.frame.size.height
#define AVATAR_OFFSET   ( 10.0f )

#define NEW_ISSUE_SEPARATOR           [UIImage imageNamed:@"newIssueSeparator.png"]
#define NEW_ISSUE_CHECK_ON            [UIImage imageNamed:@"newIssueCheckOn.png"]
#define NEW_ISSUE_CHECK_OFF           [UIImage imageNamed:@"newIssueCheckOff.png"]

@implementation BCSelectLabelsCell

+(BCSelectLabelsCell *)createLabelCellWithTableView:(UITableView *)tableView
{
  BCSelectLabelsCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectLabelsCellReuseIdentifier];
  if ( !cell ) {
    cell = [[BCSelectLabelsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectLabelsCellReuseIdentifier];
    CGRect frame;
    
    cell.checkboxImgView = [[UIImageView alloc] initWithImage:NEW_ISSUE_CHECK_OFF highlightedImage:NEW_ISSUE_CHECK_ON];
    frame.origin = CGPointMake(cell.frame.size.width - (CHECKBOX_OFFSET+cell.checkboxImgView.frame.size.width), (cell.frame.size.height-cell.checkboxImgView.frame.size.height)/2);
    frame.size = cell.checkboxImgView.frame.size;
    cell.checkboxImgView.frame = frame;
    [cell addSubview:cell.checkboxImgView];
    
    cell.BCLabelColorImgView = [[BCLabelColorImgView alloc] init];
    [cell.BCLabelColorImgView setOrigin:CGPointMake(AVATAR_OFFSET, (cell.frame.size.height-AVATAR_HEIGHT)/2)];
    [cell addSubview:cell.BCLabelColorImgView];
    
    cell.myTextLabel = [[UILabel alloc] init];
    cell.myTextLabel.font = CELL_FONT;
    cell.myTextLabel.textColor = FONT_COLOR;
    frame.size = cell.frame.size;
    frame.size.width = frame.size.width - ((2*CHECKBOX_OFFSET)+cell.checkboxImgView.frame.size.width+AVATAR_WIDTH+AVATAR_OFFSET);
    frame.origin = CGPointMake(AVATAR_WIDTH+(2*AVATAR_OFFSET), (cell.frame.size.height-frame.size.height)/2);
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

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
  UIColor *myBCLabelColor = [self.BCLabelColorImgView backgroundColor];
  [super setSelected:selected animated:animated];
  [self.BCLabelColorImgView setBackgroundColor:myBCLabelColor];
}

@end
