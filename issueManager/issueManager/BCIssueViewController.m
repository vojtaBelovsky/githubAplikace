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
#import "BCAddIssueViewController.h"
#import "UIAlertView+errorAlert.h"
#import "BCUser.h"
#import <QuartzCore/QuartzCore.h>
#import "BCIssueTitleLabel.h"
#import "BCLabelView.h"
#import "BCLabel.h"

#define GRAY_FONT_COLOR     [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]
#define WHITE_COLOR         [UIColor whiteColor]

@interface BCIssueViewController ()

@end

@implementation BCIssueViewController

#pragma mark -
#pragma mark lifecycles

- (id) initWithRepositories:(NSArray *)repositories{
    self = [super init];
    if(self){
      [self setTitle:NSLocalizedString(@"issues", @"")];
      _repositories = repositories;
      _nthRepository = [[NSNumber alloc] initWithInt:0];
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonAction)];
      
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  BCIssueDetailViewController *issueDetailViewController = [[BCIssueDetailViewController alloc] initWithIssue:[_dataSource.issues objectAtIndex:indexPath.row] andController:self];
  [self.navigationController pushViewController:issueDetailViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  [_tableView.tableView reloadData];
}

- (void)loadView {
  BCUser *currentUser = [BCUser sharedInstanceChangeableWithUser:nil succes:nil failure:nil];
  _tableView = [[BCIssueView alloc] initWithUserName:currentUser.userLogin];
  [_tableView.addNewIssueButton addTarget:self action:@selector(addButtonDidPress) forControlEvents:UIControlEventTouchDown];
  self.view = _tableView;
  
  [self createModelFromRepository:[_repositories objectAtIndex:[_nthRepository integerValue]]];
  [_tableView.tableView setDelegate:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  BCIssue *currentIssue = [_dataSource.issues objectAtIndex:indexPath.row];
  return [BCIssue heightOfIssueInProfileWithIssue:currentIssue];
}

#pragma mark -
#pragma mark buttonActions

- (void)addButtonDidPress{
  [self createAndPushAddIssueVC];
}

#pragma mark -
#pragma mark public

-(void)addNewIssue:(BCIssue *)newIssue{
  [_dataSource addNewIssue:newIssue];
  [_tableView.tableView setDataSource:_dataSource];
}

-(void)changeIssue:(BCIssue *)issue{
  [_dataSource changeIssue:issue atIndex:[_tableView.tableView indexPathForSelectedRow].row];
}

#pragma mark -
#pragma mark private



-(void)createAndPushAddIssueVC{
  BCAddIssueViewController *addIssueVC = [[BCAddIssueViewController alloc] initWithRepository:[_repositories objectAtIndex:[_nthRepository integerValue]] andController:self];
  [self.navigationController pushViewController:addIssueVC animated:YES];
}

-(void)createModelFromRepository:(BCRepository *)repository{
  [BCRepository getAllMilestonesOfRepository:[_repositories objectAtIndex:[_nthRepository integerValue]] withSuccess:^(NSMutableArray *allMilestones) {
    [BCIssue getAllIssuesFromRepository:repository WithSuccess:^(NSMutableArray *issues) {
      _dataSource = [[BCIssueDataSource alloc] initWithIssues:issues andMilestones:allMilestones];
      [_tableView.tableView setDataSource:_dataSource];
      [_tableView.tableView reloadData];
    } failure:^(NSError *error) {
      [UIAlertView showWithError:error];
    }];
  } failure:^(NSError *error) {
    [UIAlertView showWithError:error];
  }];
  
}

@end
