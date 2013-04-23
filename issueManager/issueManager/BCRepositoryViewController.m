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

@interface BCRepositoryViewController ()
- (void)createModel;
@end

@implementation BCRepositoryViewController

#pragma mark -
#pragma mark LifeCycles

- (id)init {
    self = [super init];
    if ( self ) {
        [self setTitle:NSLocalizedString(@"Repositories", @"")];
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
    _repoView = [[BCRepositoryView alloc] init];
    self.view = _repoView;
    [self createModel];
    [_repoView.tableView setDataSource:_dataSource];
    [_repoView.tableView setDelegate:self];
    [_repoView.tableView reloadData];
}

#pragma mark -
#pragma mark Private

-(void)createModel{
    [BCRepository getAllRepositoriesWithSuccess:^(NSArray *repositories) {
        _dataSource = [[BCRepositoryDataSource alloc] initWithRepositories:repositories];
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}


@end
