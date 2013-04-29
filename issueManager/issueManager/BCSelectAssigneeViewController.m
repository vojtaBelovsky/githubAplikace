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

@interface BCSelectAssigneeViewController ()

@end

@implementation BCSelectAssigneeViewController

- (id)initWithRepository:(BCRepository *)repository{
    self = [super init];
    if (self) {
        _repository = repository;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[BCSelectAssigneeView alloc] init];
    [_tableView.tableView setDelegate:self];
    [self setView:_tableView];
    [self createModel];
    
	// Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark private

-(void)createModel{
    [BCRepository getAllCollaboratorsOfRepository:_repository withSuccess:^(NSArray *allCollaborators) {
        _dataSource = [[BCSelectAssigneeDataSource alloc] initWithCollaborators:allCollaborators];
        [_tableView.tableView setDataSource:_dataSource];
        [_tableView.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

@end
