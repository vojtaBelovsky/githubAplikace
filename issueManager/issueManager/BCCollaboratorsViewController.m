//
//  BCCollaboratorsViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCCollaboratorsViewController.h"
#import "BCRepository.h"
#import "BCCollaboratorsDataSource.h"
#import "BCCollaboratorsView.h"
#import "BCRepository.h"
#import "UIAlertView+errorAlert.h"
#import "BCUser.h"
#import "BCIssueViewController.h"
#import "BCAppDelegate.h"
#import "TMViewDeckController.h"

@interface BCCollaboratorsViewController ()

@end

@implementation BCCollaboratorsViewController

- (id)initWithCollaborators:(NSArray *)collaborators andIssueViewCtrl:(BCIssueViewController *)issueViewCtrl
{
  self = [super init];
  if (self) {
    BCCollaboratorsDataSource *dataSource =  [[BCCollaboratorsDataSource alloc] initWithCollaborators:collaborators];
    _dataSource = dataSource;
    _issueViewCtrl = issueViewCtrl;
  }
  return self;
}

-(void)loadView{
  _tableView = [[BCCollaboratorsView alloc] init];
  [_tableView.tableView setDelegate:self];
  self.view = _tableView;
  [_tableView.tableView setDataSource:_dataSource];
  [_tableView.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  BCUser *collaborator = [_dataSource.collaborators objectAtIndex:indexPath.row];
  if (![collaborator isEqual:_issueViewCtrl.currentUser]) {
    [_issueViewCtrl setCurrentUser:collaborator];
    [_issueViewCtrl setUserChanged:YES]; 
  }
  [_issueViewCtrl slideBackCenterView];
}

@end
