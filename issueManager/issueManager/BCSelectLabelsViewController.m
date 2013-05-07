//
//  BCSelectLabelsViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectLabelsViewController.h"
#import "BCSelectDataManager.h"
#import "BCSelectLabelsDataSource.h"
#import "BCSelectLabelsView.h"
#import "BCRepository.h"

@interface BCSelectLabelsViewController ()

@end

@implementation BCSelectLabelsViewController

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
    _tableView = [[BCSelectLabelsView alloc] init];
    [_tableView.tableView setDelegate:self];
    [self setView:_tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"select" style:UIBarButtonItemStylePlain target:self action:@selector(selectButtonAction)];
    [self createModel];
}

#pragma mark -
#pragma mark private

-(void)createModel{
    [BCRepository getAllLabelsOfRepository:_repository withSuccess:^(NSArray *allLabels) {
        _dataSource = [[BCSelectLabelsDataSource alloc] initWithLables:allLabels];
        [_tableView.tableView setDataSource:_dataSource];
        [_tableView.tableView reloadData];
        if([_controller getLabels] != [NSNull null]){
            for(BCLabel *object in [_controller getLabels]){
                [_tableView.tableView selectRowAtIndexPath:[self getIndexPathOfLabel:object] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

-(NSIndexPath*)getIndexPathOfLabel:(BCLabel *)label{
    NSUInteger row = [_dataSource.labels indexOfObject:label];
    return [NSIndexPath indexPathForRow:row inSection:0];
}

#pragma mark -
#pragma mark buttonActions

-(void) selectButtonAction{
    NSArray *selectedRows = [_tableView.tableView indexPathsForSelectedRows];
    NSMutableArray *labels = [[NSMutableArray alloc] init];
    for(NSIndexPath *object in selectedRows){
        [labels addObject:[_dataSource.labels objectAtIndex:[object row]]];
    }
    [_controller setNewLables:[[NSArray alloc] initWithArray:labels]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
