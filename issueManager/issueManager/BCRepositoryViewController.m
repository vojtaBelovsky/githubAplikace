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

- (id)initWithUser:(BCUser *)user {
    self = [super init];
    if ( self ) {
      [self setTitle:NSLocalizedString(@"Repositories", @"")];
      _chosenUser = user;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.navigationController.navigationBarHidden = NO;
  [_repoView.tableView setMultipleTouchEnabled:YES];
    
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
    [_repoView.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
  }else{
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
    //tady bude co se stane po oznaceni na repositare
  }
}


#pragma mark -
#pragma mark Private

-(void)createModel{
  __block NSMutableArray *dataSource = [[NSMutableArray alloc] init];
  
  [BCRepository getAllRepositoriesWithSuccess:^(NSArray *allRepositories) {
    [dataSource addObject:[[NSArray alloc] initWithObjects:allRepositories[0], nil ]];
    //POZOR, overit jestli nebouchne kdyz ma uzivatel 0 repozitaru!!
    if ([allRepositories count] == 1) {
      [dataSource addObject:[[NSArray alloc] init]];
    }else{
      NSMutableArray *repos = [[NSMutableArray alloc] initWithArray:allRepositories];
      [repos removeObjectAtIndex:0];
      [dataSource addObject:[[NSArray alloc] initWithArray:repos]];
    }
    [BCOrg getAllOrgsWithSuccess:^(NSArray *allOrgs) {
      __block int i = 1;
      // ------ prepsat na rekurzi ----- !!!
      for(BCOrg *object in allOrgs){
        [BCRepository getAllRepositoriesFromOrg:object WithSuccess:^(NSArray *allRepositories) {
          [dataSource addObject:[[NSArray alloc] initWithObjects:object, nil]];
          [dataSource addObject:allRepositories];
          if([allOrgs count] == i){
            _dataSource = [[BCRepositoryDataSource alloc] initWithRepositories:dataSource andNavigationController:self];
            [_repoView.tableView setDataSource:_dataSource];
            [_repoView.tableView reloadData];
          }
          i++;
        } failure:^(NSError *error) {
          [UIAlertView showWithError:error];
        }];
      }
    } failure:^(NSError *error) {
      [UIAlertView showWithError:error];
    }];
  } failure:^(NSError *error) {
    [UIAlertView showWithError:error];
  }];
}

@end
