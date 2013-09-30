//
//  BCSelectAssigneeViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeViewController.h"
#import "BCRepository.h"
#import "BCSelectAssigneeDataSource.h"
#import "BCSelectAssigneeView.h"
#import "BCIssueDetailViewController.h"
#import "BCUser.h"
#import "BCAddIssueViewController.h"

@interface BCSelectAssigneeViewController ()

@end

@implementation BCSelectAssigneeViewController

- (id)initWithController:(BCAddIssueViewController *)controller
{
  self = [super init];
  if (self) {
    _controller = controller;
  }
  return self;
}

-(void)loadView{
  _selectAssigneView = [[BCSelectAssigneeView alloc] init];
  [_selectAssigneView.tableView setDelegate:self];
  [self setView:_selectAssigneView];
  [_selectAssigneView.doneButton addTarget:self action:@selector(doneButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_selectAssigneView.cancelButton addTarget:self action:@selector(cancelButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [self createModelWithCollaborators:_controller.collaborators withCheckedAssignee:_controller.checkedAssignee];
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//  if( _checkedAssignee != nil){
//    if (indexPath.row == _checkedAssignee.row) {
//      [cell setSelected:YES];
//    }
//  }
//}

#pragma mark -
#pragma mark private

-(void)createModelWithCollaborators:(NSArray*)assignees withCheckedAssignee:(BCUser*)checkedAssignee{
  _dataSource = [[BCSelectAssigneeDataSource alloc] initWithCollaborators:assignees];
  [_selectAssigneView.tableView setDataSource:_dataSource];
  [_selectAssigneView.tableView reloadData];
  [_selectAssigneView setNeedsLayout];
  if(checkedAssignee == nil){
    _checkedAssignee = nil;
  }else{
    _checkedAssignee = [self getIndexPathOfAssignee:checkedAssignee];
    [_selectAssigneView.tableView selectRowAtIndexPath:_checkedAssignee animated:YES scrollPosition:UITableViewScrollPositionMiddle];
  }
}

-(NSIndexPath*)getIndexPathOfAssignee:(BCUser*)assignee{
  NSUInteger row = [_dataSource.collaborators indexOfObject:assignee];
  return [NSIndexPath indexPathForRow:row inSection:0];
}

#pragma mark -
#pragma mark buttonActions

-(void) cancelButtonDidPress{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void) doneButtonDidPress{
  if (_checkedAssignee == nil) {
    [_controller setCheckedAssignee:nil];
  }else{
    [_controller setCheckedAssignee:[_dataSource.collaborators objectAtIndex:_checkedAssignee.row]];
  }
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if (_checkedAssignee == nil) {
    _checkedAssignee = indexPath;
  }else{
    if (_checkedAssignee.row == indexPath.row) {
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
      _checkedAssignee = nil;
    }else{
      [[tableView cellForRowAtIndexPath:_checkedAssignee] setSelected:NO];
      _checkedAssignee = indexPath;
    }
  }
}

@end
