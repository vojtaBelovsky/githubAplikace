//
//  BCRepositoryViewController.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 4/19/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryViewController.h"
#import "BCRepositoryView.h"
#import "BCRepository.h"
#import "BCRepositoryDataSource.h"
#import "BCIssueViewController.h"
#import "BCUser.h"
#import "BCOrg.h"
#import "UIAlertView+errorAlert.h"

@interface BCRepositoryViewController ()
- (void)createModel;
@end

@implementation BCRepositoryViewController

#pragma mark -
#pragma mark LifeCycles

- (id)init{
    self = [super init];
    if ( self ) {
      [self setTitle:NSLocalizedString(@"Choose repositories", @"")];
      _chosenRepositories = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView {
  [super loadView];
  self.navigationController.navigationBarHidden = NO;
  [self.navigationItem setHidesBackButton:YES];
  [_repoView.tableView setMultipleTouchEnabled:YES];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"select" style:UIBarButtonItemStylePlain target:self action:@selector(selectButtonDidPress)];
  
  _repoView = [[BCRepositoryView alloc] init];
  self.view = _repoView;
  [self createModel];
  [_repoView.tableView setDelegate:self];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
  if([indexPath section]%2 == 0){
    [_dataSource.actualSelected replaceObjectAtIndex:[indexPath section] withObject:[NSNumber numberWithBool:NO]];
    NSInteger rowsNumber = [_dataSource getNumberOfRowsToAddToSection:[indexPath section]+1];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:rowsNumber];
    for (int i = 0; i < rowsNumber; i++) {
      [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:[indexPath section]+1]];
    }
    [_repoView.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
  }else{
    [_chosenRepositories removeObject:[_dataSource getRepositoryAtIndex:indexPath]];
    //tady bude co se stane po ODoznaceni na repositare

  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if([indexPath section]%2 == 0){
    
    
    [_dataSource.actualSelected replaceObjectAtIndex:[indexPath section] withObject:[NSNumber numberWithBool:YES]];
    NSInteger rowsNumber = [_dataSource getNumberOfRowsToAddToSection:[indexPath section]+1];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:rowsNumber];
    for (int i = 0; i < rowsNumber; i++) {
      [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:[indexPath section]+1]];
    }
    [_repoView.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
  }else{
    [_chosenRepositories addObject:[_dataSource getRepositoryAtIndex:indexPath]];
    //tady bude co se stane po oznaceni na repositare
    
  }
}

#pragma mark -
#pragma mark buttons

-(void)selectButtonDidPress{
  BCIssueViewController *issueVC = [[BCIssueViewController alloc] initWithRepositories:_chosenRepositories];
  [self.navigationController pushViewController:issueVC animated:YES];
}


#pragma mark -
#pragma mark Private

-(void)createModel{
  __block NSMutableArray *dataSource = [[NSMutableArray alloc] init];
  
  BCUser *loggedInUser = [BCUser sharedInstanceChangeableWithUser:nil succes:nil failure:nil];
  [dataSource addObject:[[NSArray alloc] initWithObjects:loggedInUser, nil]];
  
  [BCRepository getAllRepositoriesOfUserWithSuccess:^(NSArray *allRepositories) {
    //POZOR, overit chovani apky kdyz ma uzivatel 0 repozitaru!!
    if ([allRepositories count] == 0) {
      [dataSource addObject:[[NSArray alloc] init]];
    }else{
      [dataSource addObject:allRepositories];
    }
    [BCOrg getAllOrgsWithSuccess:^(NSArray *allOrgs) {
      if([allOrgs count] > 0){
        __block NSArray *allOrgsCopy = allOrgs;
        __block int i = 0;
        //// COPY!!!!!!!!!
        __block void (^myFailureBlock) (NSError *error);
        myFailureBlock = [^ (NSError *error) {
          [UIAlertView showWithError:error];
        } copy];
        //// COPY!!!!!!!!!!!
        __block void (^mySuccessBlock) (NSArray *allRepositories);
        mySuccessBlock = [^ (NSArray *allRepositories){
          [dataSource addObject:[[NSArray alloc] initWithObjects:allOrgsCopy[i], nil]];
          [dataSource addObject:allRepositories];
          i++;
          if([allOrgsCopy count] == (i)){
            _dataSource = [[BCRepositoryDataSource alloc] initWithRepositories:dataSource andNavigationController:self];
            [_repoView.tableView setDataSource:_dataSource];
            [_repoView.tableView reloadData];
          }else{
            [BCRepository getAllRepositoriesFromOrg:allOrgsCopy[i] WithSuccess:mySuccessBlock failure:myFailureBlock];
          }
        } copy];
        [BCRepository getAllRepositoriesFromOrg:allOrgsCopy[i] WithSuccess:mySuccessBlock failure:myFailureBlock];
      }else{//set data source in case of user don't have Orgs
        _dataSource = [[BCRepositoryDataSource alloc] initWithRepositories:dataSource andNavigationController:self];
        [_repoView.tableView setDataSource:_dataSource];
        [_repoView.tableView reloadData];
      }
    } failure:^(NSError *error) {
      [UIAlertView showWithError:error];
    }];
  } failure:^(NSError *error) {
    [UIAlertView showWithError:error];
  }];

}

@end
