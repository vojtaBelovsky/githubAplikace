//
//  BCSelectMilestoneViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectMilestoneViewController.h"
#import "BCRepository.h"
#import "BCSelectMilestoneDataSource.h"
#import "BCSelectMilestoneView.h"
#import "BCSelectDataManager.h"

@interface BCSelectMilestoneViewController ()

@end

@implementation BCSelectMilestoneViewController

- (id)initWithRepository:(BCRepository *)repository andController:(UIViewController<BCSelectDataManager> *)controller
{
    self = [super init];
    if (self) {
        _repository = repository;
        _controller = controller;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[BCSelectMilestoneView alloc] init];
    [_tableView.tableView setDelegate:self];
    [self setView:_tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"select" style:UIBarButtonItemStylePlain target:self action:@selector(selectButtonAction)];
    [self createModel];
}

#pragma mark -
#pragma mark private

-(void)createModel{
    [BCRepository getAllMilestonesOfRepository:_repository withSuccess:^(NSArray *allMilestones) {
        _dataSource = [[BCSelectMilestoneDataSource alloc] initWithMilestones:allMilestones];
        [_tableView.tableView setDataSource:_dataSource];
        [_tableView.tableView reloadData];
        if([_controller getMilestone] != [NSNull null]){
            [_tableView.tableView selectRowAtIndexPath:[self getIndexPathOfSelectedRow] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

-(NSIndexPath*)getIndexPathOfSelectedRow{
    NSUInteger row = [_dataSource.milestones indexOfObject:[_controller getMilestone]];
    return [NSIndexPath indexPathForRow:row inSection:0];
}

#pragma mark -
#pragma mark buttonActions

-(void) selectButtonAction{
    NSInteger selectedRow = [_tableView.tableView indexPathForSelectedRow].row;
    [_controller setNewMilestone:[_dataSource.milestones objectAtIndex:selectedRow]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
