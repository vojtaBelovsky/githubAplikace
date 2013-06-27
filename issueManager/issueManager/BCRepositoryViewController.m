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

#define KEY_OBJECT @"object"
#define KEY_REPOSITORIES @"repositories"
#define KEY_IMAGE @"image"

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
  self.navigationController.navigationBarHidden = YES;
  [self.navigationItem setHidesBackButton:YES];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStylePlain target:self action:@selector(selectButtonDidPress)];
  
  _tableView = [[BCRepositoryView alloc] init];
  [_tableView.tableView setMultipleTouchEnabled:YES];
  [_tableView.doneButton addTarget:self action:@selector(doneButtonDidPress) forControlEvents:UIControlEventTouchDown];
  self.view = _tableView;
  [self createModel];
  [_tableView.tableView setDelegate:self];
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
  [_tableView.tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  if(indexPath.row == 0){
    if ( [[_dataSource.actualSelected objectAtIndex:indexPath.section] isEqual: [NSNumber numberWithBool:NO]] ) {
      [_dataSource.actualSelected replaceObjectAtIndex:[indexPath section] withObject:[NSNumber numberWithBool:YES]];
      NSInteger rowsNumber = [_dataSource getNumberOfRowsToAddToSection:[indexPath section]];
      NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:rowsNumber];
      for (int i = 0; i < rowsNumber; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:[indexPath section]]];
      }
      [[_tableView.tableView cellForRowAtIndexPath:indexPath] setHighlighted:YES];
      [_tableView.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    }else{
      [_dataSource.actualSelected replaceObjectAtIndex:[indexPath section] withObject:[NSNumber numberWithBool:NO]];
      NSInteger rowsNumber = [_dataSource getNumberOfRowsToAddToSection:[indexPath section]];
      NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:rowsNumber];
      for (int i = 0; i < rowsNumber; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:[indexPath section]]];
      }
      [[_tableView.tableView cellForRowAtIndexPath:indexPath] setHighlighted:NO];
      [_tableView.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
    }
  }else{
    BCRepository *repo = [_dataSource getRepositoryAtIndex:indexPath];
    if( [_chosenRepositories indexOfObject:repo] == NSNotFound){
      [_chosenRepositories addObject:repo];
      [[_tableView.tableView cellForRowAtIndexPath:indexPath] setHighlighted:YES];
    }else{
      [_chosenRepositories removeObject:repo];
      [[_tableView.tableView cellForRowAtIndexPath:indexPath] setHighlighted:NO];
    }
  }
}

#pragma mark -
#pragma mark buttons

-(void)doneButtonDidPress{
  BCIssueViewController *issueVC = [[BCIssueViewController alloc] initWithRepositories:_chosenRepositories];
  [self.navigationController pushViewController:issueVC animated:YES];
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
  
  BCUser *loggedInUser = [BCUser sharedInstanceChangeableWithUser:nil succes:nil failure:nil];
  [dataSourceKeyNames addObject:loggedInUser.userLogin];
  
  [BCRepository getAllRepositoriesOfUserWithSuccess:^(NSArray *allRepositories) {
    //POZOR, overit chovani apky kdyz ma uzivatel 0 repozitaru!!(array inicializuju, melo by tam byt 0 prvku)
    [dataAvatar setImageWithURL:loggedInUser.avatarUrl placeholderImage:placeholderImage];
    dataSourcePairs = [[NSDictionary alloc] initWithObjectsAndKeys: loggedInUser, KEY_OBJECT, allRepositories, KEY_REPOSITORIES, dataAvatar.image, KEY_IMAGE, nil];
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
        __block void (^mySuccessBlock) (NSArray *allRepositories);
        mySuccessBlock = [^ (NSArray *allRepositories){
          BCOrg *myOrg = (BCOrg *)allOrgs[i];
          i++;
          [dataAvatar setImageWithURL:[myOrg avatarUrl] placeholderImage:placeholderImage];
          [dataSourceKeyNames addObject:[myOrg orgLogin]];
          dataSourcePairs = [[NSDictionary alloc] initWithObjectsAndKeys: myOrg, KEY_OBJECT, allRepositories, KEY_REPOSITORIES, dataAvatar.image, KEY_IMAGE, nil];
          [dataSource setObject:dataSourcePairs forKey:(NSString *)dataSourceKeyNames[i]];
          if([allOrgs count] == (i)){
            _dataSource = [[BCRepositoryDataSource alloc] initWithRepositories:dataSource repositoryNames:dataSourceKeyNames andNavigationController:self];
            [_tableView.tableView setDataSource:_dataSource];
            [_tableView.tableView reloadData];
          }else{
            [BCRepository getAllRepositoriesFromOrg:allOrgs[i] WithSuccess:mySuccessBlock failure:myFailureBlock];
          }
        } copy];
        [BCRepository getAllRepositoriesFromOrg:allOrgs[i] WithSuccess:mySuccessBlock failure:myFailureBlock];
      }else{//set data source in case of user don't have Orgs
        _dataSource = [[BCRepositoryDataSource alloc] initWithRepositories:dataSource repositoryNames:dataSourceKeyNames andNavigationController:self];
        [_tableView.tableView setDataSource:_dataSource];
        [_tableView.tableView reloadData];
      }
    } failure:^(NSError *error) {
      [UIAlertView showWithError:error];
    }];
  } failure:^(NSError *error) {
    [UIAlertView showWithError:error];
  }];

}

@end
