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
#import "BCIssueDetailViewController.h"
#import "BCSelectDataManager.h"
#import "BCUser.h"

@interface BCSelectAssigneeViewController ()

@end

@implementation BCSelectAssigneeViewController

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
    _tableView = [[BCSelectAssigneeView alloc] init];
    [_tableView.tableView setDelegate:self];
    [self setView:_tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"select" style:UIBarButtonItemStylePlain target:self action:@selector(selectButtonAction)];
    [self createModel];
    
	// Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark private

-(void)createModel{
    [BCRepository getAllCollaboratorsOfRepository:_repository withSuccess:^(NSArray *allCollaborators) {
        _dataSource = [[BCSelectAssigneeDataSource alloc] initWithCollaborators:allCollaborators];
        [_tableView.tableView setDataSource:_dataSource];
        if([_controller getAssignee].userId != 0){
            [_dataSource setIsSelectedAssignee:YES];
            [_tableView.tableView selectRowAtIndexPath:[self getIndexPathOfSelectedRow] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }else{
            [_dataSource setIsSelectedAssignee:NO];
        }
        [_tableView.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

-(NSIndexPath*)getIndexPathOfSelectedRow{
    NSUInteger row = [_dataSource.collaborators indexOfObject:[_controller getAssignee]];
    return [NSIndexPath indexPathForRow:row inSection:0];
}

#pragma mark -
#pragma mark buttonActions

-(void) selectButtonAction{
    NSInteger selectedRow = [_tableView.tableView indexPathForSelectedRow].row;
    [_controller setNewAssignee:[_dataSource.collaborators objectAtIndex:selectedRow]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
