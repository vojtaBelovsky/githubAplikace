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

@interface BCCollaboratorsViewController ()

@end

@implementation BCCollaboratorsViewController

- (id)initWithRepositories:(NSArray *)repositories andIssueViewCtrl:(BCIssueViewController *)issueViewCtrl
{
  self = [super init];
  if (self) {
    _repositories = repositories;
    _issueViewCtrl = issueViewCtrl;
  }
  return self;
}

-(void)loadView{
  _tableView = [[BCCollaboratorsView alloc] init];
  [_tableView.tableView setDelegate:self];
  self.view = _tableView;
  [self createModel];  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  [BCUser sharedInstanceChangeableWithUser:[_dataSource.collaborators objectAtIndex:indexPath.row] succes:nil failure:nil];
  [_issueViewCtrl setUserChanged:YES];
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private

-(void)createModel{
  __block int i = 0;
  __block BCRepository *currentRepo = [_repositories objectAtIndex:i];
  __block NSMutableArray *allCollaborators = [[NSMutableArray alloc] init];
  __block void (^myFailureBlock) (NSError *error) = [^(NSError *error) {
    [UIAlertView showWithError:error];
  } copy];
  __block void (^mySuccessBlock) (NSArray *collaborators);
  mySuccessBlock = [^(NSArray *collaborators){    
    for (BCUser *newCollaborator in collaborators) {
      BOOL addCollaborator = YES;
      int numberOfCollaborators = [allCollaborators count];
      if (numberOfCollaborators) {
        for (int i = 0; i < numberOfCollaborators; i++){
          BCUser *currentCollaborator = [allCollaborators objectAtIndex:i];
          if ([currentCollaborator.userId isEqualToNumber:newCollaborator.userId]) {
            addCollaborator = NO;
          }
        }
        if (addCollaborator) {
          [allCollaborators addObject:newCollaborator];
        }
      }else{
        [allCollaborators addObject:newCollaborator];
      }    
    }
    i++;
    if ([_repositories count] == i) {
      _dataSource = [[BCCollaboratorsDataSource alloc] initWithCollaborators:allCollaborators];
      [_tableView.tableView setDataSource:_dataSource];
      [_tableView.tableView reloadData];
    }else{
      currentRepo = [_repositories objectAtIndex:i];
      [BCRepository getAllCollaboratorsOfRepository:currentRepo withSuccess:mySuccessBlock failure:myFailureBlock];
    }    
  } copy];
  [BCRepository getAllCollaboratorsOfRepository:currentRepo withSuccess:mySuccessBlock failure:myFailureBlock];
}

@end
