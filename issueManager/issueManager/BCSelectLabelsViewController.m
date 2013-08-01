//
//  BCSelectLabelsViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectLabelsViewController.h"
#import "BCSelectDataManager.h"
#import "BCSelectLabelsDataSource.h"
#import "BCSelectLabelsView.h"
#import "BCRepository.h"

@interface BCSelectLabelsViewController ()

@end

@implementation BCSelectLabelsViewController

- (id)initWithRepository:(BCRepository *)repository andController:(UIViewController<BCSelectDataManager> *)controller
{
  self = [super init];
  if (self) {
    _repository = repository;
    _controller = controller;
    _checkedLabels = [[NSMutableArray alloc] init];
  }
  return self;
}

-(void)loadView{
  _BCSelectLabelsView = [[BCSelectLabelsView alloc] init];
  [_BCSelectLabelsView.tableView setDelegate:self];
  [self setView:_BCSelectLabelsView];
  [_BCSelectLabelsView.doneButton addTarget:self action:@selector(doneButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_BCSelectLabelsView.cancelButton addTarget:self action:@selector(cancelButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [self createModel];
}

#pragma mark -
#pragma mark private

-(void)createModel{
  [BCRepository getAllLabelsOfRepository:_repository withSuccess:^(NSArray *allLabels) {
    _dataSource = [[BCSelectLabelsDataSource alloc] initWithLables:allLabels];
    [_BCSelectLabelsView.tableView setDataSource:_dataSource];
    [_BCSelectLabelsView.tableView reloadData];
    NSArray *checkedLabels = [_controller getLabels];
    if(checkedLabels != nil){
      for (BCLabel *object in checkedLabels) {
        [_checkedLabels addObject:[self getIndexPathOfLabel:object]];
      }
    }
    for (NSIndexPath *object in _checkedLabels) {
      [_BCSelectLabelsView.tableView selectRowAtIndexPath:object animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
  } failure:^(NSError *error) {
    NSLog(@"fail");
  }];
}

-(NSIndexPath*)getIndexPathOfLabel:(BCLabel *)label{
    NSUInteger row = [_dataSource.labels indexOfObject:label];
    return [NSIndexPath indexPathForRow:row inSection:0];
}

#pragma mark -
#pragma mark buttonActions


-(void) cancelButtonDidPress{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void) doneButtonDidPress{
  NSArray *selectedRows = [_BCSelectLabelsView.tableView indexPathsForSelectedRows];
  
  if ([selectedRows count] == 0) {
    [_controller setNewLables:nil];
  }else{
    NSMutableArray *labels = [[NSMutableArray alloc] init];
    for(NSIndexPath *object in selectedRows){
      [labels addObject:[_dataSource.labels objectAtIndex:[object row]]];
    }
    [_controller setNewLables:[[NSArray alloc] initWithArray:labels]];
    [self.navigationController popViewControllerAnimated:YES];
  }
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//  if (_checkedAssignee == nil) {
//    _checkedAssignee = indexPath;
//  }else{
//    if (_checkedAssignee.row == indexPath.row) {
//      [tableView deselectRowAtIndexPath:indexPath animated:YES];
//      _checkedAssignee = nil;
//    }else{
//      [[tableView cellForRowAtIndexPath:_checkedAssignee] setSelected:NO];
//      _checkedAssignee = indexPath;
//    }
//  }
}

@end
