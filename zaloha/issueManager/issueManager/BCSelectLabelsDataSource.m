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

  [cell.labelColorImgView setBackgroundColor:label.color];
  
  [cell.myTextLabel setText:label.name];
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_labels count];
}

@end