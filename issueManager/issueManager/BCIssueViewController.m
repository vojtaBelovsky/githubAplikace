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
#import "BCHeadeView.h"
#import "BCIssueCell.h"

#define GRAY_FONT_COLOR     [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]
#define WHITE_COLOR         [UIColor whiteColor]
#define HEADER_HEIGHT       ( 40.0f )

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
      _nthRepository = 0;
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonAction)];
      
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  BCIssueDetailViewController *issueDetailViewController = [[BCIssueDetailViewController alloc] initWithIssue:[self getIssueForIndexPath:indexPath] andController:self];
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
  
  [self createModelFromRepository:[_repositories objectAtIndex:_nthRepository]];
  [_tableView.tableView setDelegate:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  BCIssue *currentIssue = [self getIssueForIndexPath:indexPath];
  return [BCIssueCell heightOfCellWithIssue:currentIssue width:ISSUE_WIDTH titleFont:TITLE_FONT offset:OFFSET];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  if (_dataSource != nil) {
    BCIssue *currentIssue = [[_dataSource.dataSource objectForKey:[_dataSource.dataSourceKeyNames objectAtIndex:section]] objectAtIndex:0];
    BCHeadeView *headerView = [[BCHeadeView alloc] initWithFrame:CGRectMake(0, _tableView.navigationBarView.frame.size.height, _tableView.frame.size.width, HEADER_HEIGHT) andMilestone:currentIssue.milestone];
    return headerView;
  }else{
    return nil;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  return HEADER_HEIGHT;
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

-(void)changeIssue:(BCIssue *)issue forNewIssue:(BCIssue*)newIssue{
  [_dataSource changeIssue:issue forNewIssue:newIssue];
}

#pragma mark -
#pragma mark private

-(BCIssue *)getIssueForIndexPath:(NSIndexPath *)indexPath{
  return [(NSArray*)[_dataSource.dataSource objectForKey:[_dataSource.dataSourceKeyNames objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
}

-(void)createAndPushAddIssueVC{
  BCAddIssueViewController *addIssueVC = [[BCAddIssueViewController alloc] initWithRepository:[_repositories objectAtIndex:_nthRepository] andController:self];
  [self.navigationController pushViewController:addIssueVC animated:YES];
}

-(void)createModelFromRepository:(BCRepository *)repository{
  [BCRepository getAllMilestonesOfRepository:[_repositories objectAtIndex:_nthRepository] withSuccess:^(NSMutableArray *allMilestones) {
    [BCIssue getAllIssuesFromRepository:repository WithSuccess:^(NSMutableArray *issues) {
      _dataSource = [[BCIssueDataSource alloc] initWithIssues:issues milestones:allMilestones];
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
