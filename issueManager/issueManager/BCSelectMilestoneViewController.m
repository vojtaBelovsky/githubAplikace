//
//  BCSelectMilestoneViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectMilestoneViewController.h"
#import "BCRepository.h"
#import "BCSelectMilestoneDataSource.h"
#import "BCSelectMilestoneView.h"
#import "BCMilestone.h"
#import "BCSelectMilestoneCell.h"
#import "BCAddIssueViewController.h"

#define NEW_ISSUE_CHECK_ON            [UIImage imageNamed:@"newIssueCheckOn.png"]
#define NEW_ISSUE_CHECK_OFF           [UIImage imageNamed:@"newIssueCheckOff.png"]

@interface BCSelectMilestoneViewController ()

@end

@implementation BCSelectMilestoneViewController

- (id)initWithController:(BCAddIssueViewController *)controller
{
  self = [super init];
  if (self) {
    _controller = controller;
  }
  return self;
}

-(void)loadView{
  _selectMilestoneView = [[BCSelectMilestoneView alloc] init];
  [_selectMilestoneView.tableView setDelegate:self];
  [self setView:_selectMilestoneView];
  [_selectMilestoneView.doneButton addTarget:self action:@selector(doneButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_selectMilestoneView.cancelButton addTarget:self action:@selector(cancelButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [self createModelWithMilestones:_controller.milestones andCheckedMilestone:_controller.checkedMilestone];
}

#pragma mark -
#pragma mark private

-(void)createModelWithMilestones:(NSArray*)milestones andCheckedMilestone:(BCMilestone*)checkedMilestone {
  _dataSource = [[BCSelectMilestoneDataSource alloc] initWithMilestones:milestones];
  [_selectMilestoneView.tableView setDataSource:_dataSource];
  if(checkedMilestone != nil){
    _checkedMilestone = [self getIndexPathOfMilestone:checkedMilestone];
    [_selectMilestoneView.tableView selectRowAtIndexPath:_checkedMilestone animated:YES scrollPosition:UITableViewScrollPositionMiddle];
  }else{
    _checkedMilestone = nil;
  }
}

-(NSIndexPath*)getIndexPathOfMilestone:(BCMilestone*)milestone{
  NSUInteger row = [_dataSource.milestones indexOfObject:milestone];
  return [NSIndexPath indexPathForRow:row inSection:0];
}

#pragma mark -
#pragma mark buttonActions

-(void) cancelButtonDidPress{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void) doneButtonDidPress{
  if (_checkedMilestone == nil) {
    [_controller setCheckedMilestone:nil];
  }else{
    [_controller setCheckedMilestone:[_dataSource.milestones objectAtIndex:_checkedMilestone.row]];
  }
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if (_checkedMilestone == nil) {
    _checkedMilestone = indexPath;
  }else{
    if (_checkedMilestone.row == indexPath.row) {
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
      _checkedMilestone = nil;
    }else{
      [[tableView cellForRowAtIndexPath:_checkedMilestone] setSelected:NO];
      _checkedMilestone = indexPath;
    }
  }
}

@end
