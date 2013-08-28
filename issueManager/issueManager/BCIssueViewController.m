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
#import "BCCollaboratorsViewController.h"

#define GRAY_FONT_COLOR     [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]
#define WHITE_COLOR         [UIColor whiteColor]
#define HEADER_HEIGHT       ( 40.0f )

#define MILESTONES_KEY      @"milestones"
#define ISSUES_KEY          @"issues"

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
      _userChanged = NO;
        _allDataSources = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  int index = [_tableView.allTableViews indexOfObject:tableView];
  BCIssueDetailViewController *issueDetailViewController = [[BCIssueDetailViewController alloc] initWithIssue:[self getIssueForIndexPath:indexPath fromNthRepository:index] andController:self];
  [self presentViewController:issueDetailViewController animated:YES completion:^{
    
  }];
//  [self.navigationController pushViewController:issueDetailViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
  if (_userChanged) {
    [self createModel];
  }
  [super viewWillAppear:animated];
  [[_tableView.allTableViews objectAtIndex:_nthRepository] reloadData];
  [_tableView setNeedsLayout];
}

- (void)loadView {
  _tableView = [[BCIssueView alloc] initWithNumberOfRepos:[_repositories count]];
  [_tableView.tableViews setDelegate:self];
  [_tableView.addNewIssueButton addTarget:self action:@selector(addButtonDidPress) forControlEvents:UIControlEventTouchDown];
  [_tableView.chooseCollaboratorButton addTarget:self action:@selector(chooseButtonDidPress) forControlEvents:UIControlEventTouchDown];
  self.view = _tableView;
  
  [self createModel];
  for (int i = 0; i < [_repositories count]; i++) {
    [[_tableView.allTableViews objectAtIndex:i] setDelegate:self];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  int index = [_tableView.allTableViews indexOfObject:tableView];
  BCIssue *currentIssue = [self getIssueForIndexPath:indexPath fromNthRepository:index];
  return [BCIssueCell heightOfCellWithIssue:currentIssue width:ISSUE_WIDTH titleFont:TITLE_FONT offset:OFFSET];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  int index = [_tableView.allTableViews indexOfObject:tableView];
  if ([_allDataSources count] > index) {
    BCIssueDataSource *currentDataSource = [_allDataSources objectAtIndex:index];
    BCIssue *currentIssue = [[currentDataSource.dataSource objectForKey:[currentDataSource.dataSourceKeyNames objectAtIndex:section]] objectAtIndex:0];
    BCHeadeView *headerView = [[BCHeadeView alloc] initWithFrame:CGRectMake(0, _tableView.navigationBarView.frame.size.height, _tableView.frame.size.width, HEADER_HEIGHT) andMilestone:currentIssue.milestone];
    return headerView;
  }else{
    return nil;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  return HEADER_HEIGHT;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  int contentOffset = scrollView.contentOffset.x;
  if (contentOffset%(int)self.view.frame.size.width == 0) {
    int originalOffset = _nthRepository*self.view.frame.size.width;
    if (contentOffset != originalOffset) {
      if (contentOffset < originalOffset) {
        _nthRepository--;
      }else{
        _nthRepository++;
      }
    }
  }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
  
}

#pragma mark -
#pragma mark buttonActions

- (void)addButtonDidPress{
  BCAddIssueViewController *addIssueVC = [[BCAddIssueViewController alloc] initWithRepository:[_repositories objectAtIndex:_nthRepository] andController:self];
  [self.navigationController pushViewController:addIssueVC animated:YES];
}

-(void)chooseButtonDidPress{
  BCCollaboratorsViewController *chooseCollVC = [[BCCollaboratorsViewController alloc] initWithRepositories:_repositories andIssueViewCtrl:self];
  [self.navigationController pushViewController:chooseCollVC animated:YES];
}

#pragma mark -
#pragma mark public

-(void)addNewIssue:(BCIssue *)newIssue{
  BCIssueDataSource *currentDataSource = [_allDataSources objectAtIndex:_nthRepository];
  [currentDataSource addNewIssue:newIssue];
  [[_tableView.allTableViews objectAtIndex:_nthRepository] setDataSource:currentDataSource];
}

//to the future, for changing issues
-(void)changeIssue:(BCIssue *)issue forNewIssue:(BCIssue*)newIssue{
  [[_allDataSources objectAtIndex:_nthRepository] changeIssue:issue forNewIssue:newIssue];
}

-(void)removeIssue:(BCIssue *)issue{
  [[_allDataSources objectAtIndex:_nthRepository] removeIssue:issue];
}

#pragma mark -
#pragma mark private

-(BCIssue *)getIssueForIndexPath:(NSIndexPath *)indexPath fromNthRepository:(int)nthRepository{
  BCIssueDataSource *currentDataSource = [_allDataSources objectAtIndex:nthRepository];
  BCIssue *myIssue = [[currentDataSource.dataSource objectForKey:[currentDataSource.dataSourceKeyNames objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
  return myIssue;
}

-(void)createModel{
//  [_allDataSources removeAllObjects];
  __block int i = 0;
  __block BCUser *currentUser = [BCUser sharedInstanceChangeableWithUser:nil succes:nil failure:nil];
  [_tableView setUserName:currentUser.userLogin];
  __block void (^myFailureBlock) (NSError *error) = [^(NSError *error){
    [UIAlertView showWithError:error];
  } copy];
  __block void (^milestonesSuccessBlock) (NSMutableArray *milestones);
  milestonesSuccessBlock = [^(NSMutableArray *milestones) {
    [BCIssue getIssuesFromRepository:[_repositories objectAtIndex:i] forUser:currentUser since:nil WithSuccess:^(NSMutableArray *issues){
      BCIssueDataSource *currentDataSource = [[BCIssueDataSource alloc] initWithIssues:issues milestones:milestones];
      if ( _allDataSources.count > i ){
        [_allDataSources replaceObjectAtIndex:i withObject:currentDataSource];
      } else {
        [_allDataSources addObject:currentDataSource];
      }
      [[_tableView.allTableViews objectAtIndex:i] setDataSource:currentDataSource];
      [[_tableView.allTableViews objectAtIndex:i] reloadData];
      i++;
      if (i != [_repositories count]) {
        [BCRepository getAllMilestonesOfRepository:[_repositories objectAtIndex:i] withSuccess:milestonesSuccessBlock failure:myFailureBlock];
      }
    }failure:myFailureBlock];
  } copy];
  
  [BCRepository getAllMilestonesOfRepository:[_repositories objectAtIndex:i] withSuccess:milestonesSuccessBlock failure:myFailureBlock];

}

@end
