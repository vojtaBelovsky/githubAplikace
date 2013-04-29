//
//  BCIssueViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueViewController.h"
#import "BCRepository.h"
#import "BCIssue.h"
#import "BCIssueView.h"
#import "BCIssueDataSource.h"
#import "BCIssueDetailViewController.h"

@interface BCIssueViewController ()

@end

@implementation BCIssueViewController

- (id) initWithRepository:(BCRepository *)repository{
    self = [super init];
    if(self){
        [self setTitle:NSLocalizedString(@"issues", @"")];
        _repository = repository;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonAction)];
    }
    return self;
}

- (void)addButtonAction{
    NSLog(@"do action");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BCIssueDetailViewController *issueDetailViewController = [[BCIssueDetailViewController alloc] initWithIssue: [_dataSource.issues objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:issueDetailViewController animated:YES];
}

- (void)loadView {
    [super loadView];
    _tableView = [[BCIssueView alloc] init];
    self.view = _tableView;
    [self createModel];
    [_tableView.tableView setDelegate:self];
}

#pragma mark -
#pragma mark private

-(void)createModel{
    [BCIssue getAllIssuesFromRepository:_repository WithSuccess:^(NSArray *issues) {
        _dataSource = [[BCIssueDataSource alloc] initWithIssues:issues];
        [_tableView.tableView setDataSource:_dataSource];
        [_tableView.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

@end
