//
//  BCSelectLabelsViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectLabelsViewController.h"
#import "BCSelectLabelsDataSource.h"
#import "BCSelectLabelsView.h"
#import "BCRepository.h"
#import "BCAddIssueViewController.h"
#import "BCLabel.h"

@interface BCSelectLabelsViewController ()

@end

@implementation BCSelectLabelsViewController

- (id)initWithController:(BCAddIssueViewController *)controller
{
  self = [super init];
  if (self) {
    _controller = controller;
  }
  return self;
}

-(void)loadView{
  _BCSelectLabelsView = [[BCSelectLabelsView alloc] init];
  [_BCSelectLabelsView.tableView setDelegate:self];
  [self setView:_BCSelectLabelsView];
  [_BCSelectLabelsView.doneButton addTarget:self action:@selector(doneButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_BCSelectLabelsView.cancelButton addTarget:self action:@selector(cancelButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [self createModelWithLabels:_controller.labels withCheckedLabels:_controller.checkedLabels];
}

#pragma mark -
#pragma mark private

-(void)createModelWithLabels:(NSArray*)labels withCheckedLabels:(NSArray*)checkedLabels{
  
  _dataSource = [[BCSelectLabelsDataSource alloc] initWithLables:labels];
  [_BCSelectLabelsView.tableView setDataSource:_dataSource];
  if(checkedLabels != nil){
    for (BCLabel *object in checkedLabels) {
      [_checkedLabels addObject:[self getIndexPathOfLabel:object]];
    }
  }
  for (NSIndexPath *object in _checkedLabels) {
    [_BCSelectLabelsView.tableView selectRowAtIndexPath:object animated:NO scrollPosition:UITableViewScrollPositionNone];
  }
  [_BCSelectLabelsView.tableView reloadData];
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
    [_controller setCheckedLabels:nil];
  }else{
    NSMutableArray *labels = [[NSMutableArray alloc] init];
    for(NSIndexPath *object in selectedRows){
      [labels addObject:[_dataSource.labels objectAtIndex:[object row]]];
    }
    [_controller setCheckedLabels:labels];
    [self.navigationController popViewControllerAnimated:YES];
  }
  [self.navigationController popViewControllerAnimated:YES];
}

@end
