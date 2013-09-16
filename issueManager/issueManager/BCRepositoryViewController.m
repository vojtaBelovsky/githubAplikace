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
#import "UIImageView+AFNetworking.h"
#import "TMViewDeckController.h"
#import "BCAppDelegate.h"

#define KEY_OBJECT        @"object"
#define KEY_REPOSITORIES  @"repositories"
#define KEY_IMAGE         @"image"

@interface BCRepositoryViewController ()
- (void)createModel;
@end

@implementation BCRepositoryViewController

#pragma mark -
#pragma mark LifeCycles

- (id)init{
    self = [super init];
    if ( self ) {
      _chosenRepositories = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView {
  [self.navigationController setNavigationBarHidden:YES];
  _repoView = [[BCRepositoryView alloc] init];
  [_repoView.tableView setMultipleTouchEnabled:YES];
  self.view = _repoView;
  [_repoView.doneButton addTarget:self action:@selector(doneButtonDidPress) forControlEvents:UIControlEventTouchDown];
  [self createModel];
  [_repoView.tableView setDelegate:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.row != 0) {
    if([_chosenRepositories containsObject:[_dataSource getRepositoryAtIndex:indexPath]]){
      [cell setHighlighted:YES];
    }
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [_repoView.tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  if(indexPath.row == 0){
    if ( [[_dataSource.actualSelected objectAtIndex:indexPath.section] isEqual: [NSNumber numberWithBool:NO]] ) {
      [_dataSource.actualSelected replaceObjectAtIndex:[indexPath section] withObject:[NSNumber numberWithBool:YES]];
      NSInteger rowsNumber = [_dataSource getNumberOfRowsToAddToSection:[indexPath section]];
      NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:rowsNumber];
      for (int i = 0; i < rowsNumber; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:[indexPath section]]];
      }
      [[_repoView.tableView cellForRowAtIndexPath:indexPath] setHighlighted:YES];
      [_repoView.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    }else{
      [_dataSource.actualSelected replaceObjectAtIndex:[indexPath section] withObject:[NSNumber numberWithBool:NO]];
      NSInteger rowsNumber = [_dataSource getNumberOfRowsToAddToSection:[indexPath section]];
      NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:rowsNumber];
      for (int i = 0; i < rowsNumber; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:[indexPath section]]];
      }
      [[_repoView.tableView cellForRowAtIndexPath:indexPath] setHighlighted:NO];
      [_repoView.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
    }
  }else{
    BCRepository *repo = [_dataSource getRepositoryAtIndex:indexPath];
    if( [_chosenRepositories indexOfObject:repo] == NSNotFound){
      [_chosenRepositories addObject:repo];
      [[_repoView.tableView cellForRowAtIndexPath:indexPath] setHighlighted:YES];
    }else{
      [_chosenRepositories removeObject:repo];
      [[_repoView.tableView cellForRowAtIndexPath:indexPath] setHighlighted:NO];
    }
  }
}

#pragma mark -
#pragma mark buttons

-(void)doneButtonDidPress{
  if ([_chosenRepositories count]) {
    BCIssueViewController *issuesVC = [[BCIssueViewController alloc] initWithRepositories:_chosenRepositories];
    BCAppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    [myDelegate.deckController setAndPresentCenterController:issuesVC];
//    [self.navigationController pushViewController:deckVC animated:YES];
  }else{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Empty repository list" message:@"you can't proceed until you choose some repository/ies" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
  }
}


#pragma mark -
#pragma mark Private

-(void)createModel{
//
//  ------- menim strukturu z NSArray[NSArray] na [NSDictionary - klice jsou hodnoty v NSArray obsahujici jmena usera a organizaci [NSDictionary - object, repositories, image]]+[NSArray - klice k dictionaries v podobe userLoginu, a jmen organizaci]
//
  
  __block NSMutableDictionary *dataSource = [[NSMutableDictionary alloc] init];
  __block NSDictionary *dataSourcePairs;
  __block UIImageView *dataAvatar = [[UIImageView alloc] init];
  __block UIImage *placeholderImage = [UIImage imageNamed:@"gravatar-user-420.png"];
  __block NSMutableArray *dataSourceKeyNames = [[NSMutableArray alloc] init];
  
  BCUser *chosenUser = [BCUser sharedInstanceChangeableWithUser:nil succes:nil failure:nil];
  
  [BCUser getAllRepositoriesOfUserWithSuccess:^(NSMutableArray *allRepositories) {
    if (![allRepositories count]) {
      [allRepositories addObject:[[BCRepository alloc] initNoRepositories]];
    }
    [dataSourceKeyNames addObject:chosenUser.userLogin];
    [dataAvatar setImageWithURL:chosenUser.avatarUrl placeholderImage:placeholderImage];
    dataSourcePairs = [[NSDictionary alloc] initWithObjectsAndKeys: chosenUser, KEY_OBJECT, allRepositories, KEY_REPOSITORIES, dataAvatar.image, KEY_IMAGE, nil];
    [dataSource setObject:dataSourcePairs forKey:(NSString *)dataSourceKeyNames[0]];
    [BCOrg getAllOrgsWithSuccess:^(NSArray *allOrgs) {
      if([allOrgs count] > 0){
        __block int i = 0;
        //// COPY!!!!!!!!!
        __block void (^myFailureBlock) (NSError *error);
        myFailureBlock = [^ (NSError *error) {
          [UIAlertView showWithError:error];
        } copy];
        //// COPY!!!!!!!!!!!
        __block void (^mySuccessBlock) (NSMutableArray *allRepositories);
        mySuccessBlock = [^ (NSMutableArray *allRepositories){
          if (![allRepositories count]) {
            [allRepositories addObject:[[BCRepository alloc] initNoRepositories]];
          }
          BCOrg *myOrg = (BCOrg *)allOrgs[i];
          i++;
          [dataAvatar setImageWithURL:[myOrg avatarUrl] placeholderImage:placeholderImage];
          [dataSourceKeyNames addObject:[myOrg orgLogin]];
          dataSourcePairs = [[NSDictionary alloc] initWithObjectsAndKeys: myOrg, KEY_OBJECT, allRepositories, KEY_REPOSITORIES, dataAvatar.image, KEY_IMAGE, nil];
          [dataSource setObject:dataSourcePairs forKey:(NSString *)dataSourceKeyNames[i]];
          if([allOrgs count] == (i)){
            _dataSource = [[BCRepositoryDataSource alloc] initWithRepositories:dataSource repositoryNames:dataSourceKeyNames andNavigationController:self];
            [_repoView.tableView setDataSource:_dataSource];
            [_repoView.tableView reloadData];
          }else{
            [BCOrg getAllRepositoriesFromOrg:allOrgs[i] WithSuccess:mySuccessBlock failure:myFailureBlock];
          }
        } copy];
        [BCOrg getAllRepositoriesFromOrg:allOrgs[i] WithSuccess:mySuccessBlock failure:myFailureBlock];
      }else{//set data source in case of user don't have Orgs
        _dataSource = [[BCRepositoryDataSource alloc] initWithRepositories:dataSource repositoryNames:dataSourceKeyNames andNavigationController:self];
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
