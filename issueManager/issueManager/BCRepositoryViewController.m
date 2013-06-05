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
        [self setTitle:NSLocalizedString(@"Repositories", @"")];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.navigationController.navigationBarHidden = NO;
    
    _repoView = [[BCRepositoryView alloc] init];
    self.view = _repoView;
    [self createModel];
    [_repoView.tableView setDelegate:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BCIssueViewController *issueViewController = [[BCIssueViewController alloc] initWithRepository:[_dataSource getRepositoryAtIndex:indexPath.row]];
    [self.navigationController pushViewController:issueViewController animated:YES];
}


#pragma mark -
#pragma mark Private

-(void)createModel{
    BCUser *chosenUser = [BCUser sharedInstanceChangeableWithInstance:nil];
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    [BCRepository getAllRepositoriesFromUser:chosenUser WithSuccess:^(NSArray *repositories) {
        [dataSource addObject:repositories];
    } failure:^(NSError *error) {
        [UIAlertView showWithError:error];
    }];
    
    __block NSArray *userOrgs = nil;
    [BCOrg getAllOrgsFromUser:chosenUser WithSuccess:^(NSArray *allOrgs) {
        userOrgs = allOrgs;
    } failure:^(NSError *error) {
        [UIAlertView showWithError:error];
    }];
    for(BCOrg *object in userOrgs){
        [BCRepository getAllRepositoriesFromOrg:<#(BCOrg *)#> WithSuccess:<#^(NSArray *allRepositories)success#> failure:<#^(NSError *error)failure#>]
    }
    [BCRepository getAllRepositoriesFromOrg:<#(BCOrg *)#> WithSuccess:<#^(NSArray *allRepositories)success#> failure:<#^(NSError *error)failure#>
    
    //to bude na konci
    _dataSource = [[BCRepositoryDataSource alloc] initWithRepositories:dataSource];
    [_repoView.tableView setDataSource:_dataSource];
    [_repoView.tableView reloadData];
}


@end
