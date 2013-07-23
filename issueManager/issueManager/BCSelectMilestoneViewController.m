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
#import "BCSelectDataManager.h"
#import "BCMilestone.h"
#import "BCSelectMilestoneCell.h"

#define NEW_ISSUE_CHECK_ON            [UIImage imageNamed:@"newIssueCheckOn.png"]
#define NEW_ISSUE_CHECK_OFF           [UIImage imageNamed:@"newIssueCheckOff.png"]

@interface BCSelectMilestoneViewController ()

@end

@implementation BCSelectMilestoneViewController

- (id)initWithRepository:(BCRepository *)repository andController:(UIViewController<BCSelectDataManager> *)controller
{
  self = [super init];
  if (self) {
    _repository = repository;
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
  [self createModel];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
  if( _checkedMilestone != nil){
    if (indexPath.row == _checkedMilestone.row) {
      [cell setSelected:YES];
    }
  }
}

#pragma mark -
#pragma mark private

-(void)createModel{
  [BCRepository getAllMilestonesOfRepository:_repository withSuccess:^(NSArray *allMilestones) {
    _dataSource = [[BCSelectMilestoneDataSource alloc] initWithMilestones:allMilestones];
    [_selectMilestoneView.tableView setDataSource:_dataSource];
    if([_controller getMilestone] == nil){
      _checkedMilestone = nil;
    }else{
      _checkedMilestone = [self getIndexPathOfSelectedRow];
    }
    [_selectMilestoneView.tableView reloadData];
  } failure:^(NSError *error) {
    NSLog(@"fail");
  }];
}



-(NSIndexPath*)getIndexPathOfSelectedRow{
  NSUInteger row = [_dataSource.milestones indexOfObject:[_controller getMilestone]];
  return [NSIndexPath indexPathForRow:row inSection:0];
}

#pragma mark -
#pragma mark buttonActions

-(void) cancelButtonDidPress{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void) doneButtonDidPress{
  if (_checkedMilestone == nil) {
    [_controller setNewMilestone:nil];
  }else{
    [_controller setNewMilestone:[_dataSource.milestones objectAtIndex:_checkedMilestone.row]];
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
