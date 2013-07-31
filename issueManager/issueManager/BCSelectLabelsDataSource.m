//
//  BCSelectLabelsDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectLabelsDataSource.h"
#import "BCSelectLabelsCell.h"
#import "BCLabel.h"
#import "BCLabelColorImgView.h"

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation BCSelectLabelsDataSource

- (id)initWithLables:(NSArray *)labels
{
    self = [super init];
    if (self) {
        _labels = labels;
    }
    return self;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  BCSelectLabelsCell *cell = [BCSelectLabelsCell createLabelCellWithTableView:tableView];
  BCLabel *label = [_labels objectAtIndex:indexPath.row];
  unsigned result = 0;
  [[NSScanner scannerWithString:label.color] scanHexInt:&result];
  [cell.BCLabelColorImgView setBackgroundColor:UIColorFromRGB(result)];
  
  [cell.myTextLabel setText:label.name];
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_labels count];
}

@end