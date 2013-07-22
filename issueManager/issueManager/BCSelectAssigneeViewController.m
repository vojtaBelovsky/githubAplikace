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
#import "BCSelectDataManager.h"
#import "BCUser.h"

@interface BCSelectAssigneeViewController ()

@end

@implementation BCSelectAssigneeViewController

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
  _BCSelectAssigneView = [[BCSelectAssigneeView alloc] init];
  [_BCSelectAssigneView.tableView setDelegate:self];
  [self setView:_BCSelectAssigneView];
  [_BCSelectAssigneView.doneButton addTarget:self action:@selector(doneButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_BCSelectAssigneView.cancelButton addTarget:self action:@selector(cancelButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [self createModel];
}

#pragma mark -
#pragma mark private

-(void)createModel{
    [BCRepository getAllCollaboratorsOfRepository:_repository withSuccess:^(NSArray *allCollaborators) {
        _dataSource = [[BCSelectAssigneeDataSource alloc] initWithCollaborators:allCollaborators];
        [_BCSelectAssigneView.tableView setDataSource:_dataSource];
        if([_controller getAssignee].userId != 0){
            [_dataSource setIsSelectedAssignee:YES];
            [_BCSelectAssigneView.tableView selectRowAtIndexPath:[self getIndexPathOfSelectedRow] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }else{
            [_dataSource setIsSelectedAssignee:NO];
        }
        [_BCSelectAssigneView.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

-(NSIndexPath*)getIndexPathOfSelectedRow{
    NSUInteger row = [_dataSource.collaborators indexOfObject:[_controller getAssignee]];
    return [NSIndexPath indexPathForRow:row inSection:0];
}

#pragma mark -
#pragma mark buttonActions

-(void) cancelButtonDidPress{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void) doneButtonDidPress{
    NSInteger selectedRow = [_BCSelectAssigneView.tableView indexPathForSelectedRow].row;
    [_controller setNewAssignee:[_dataSource.collaborators objectAtIndex:selectedRow]];
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
