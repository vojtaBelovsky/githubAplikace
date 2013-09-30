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
#import "BCAppDelegate.h"
#import "TMViewDeckController.h"

#define GRAY_FONT_COLOR       [UIColor colorWithRed:.31 green:.31 blue:.31 alpha:1.00]
#define WHITE_COLOR           [UIColor whiteColor]
#define FIRST_HEADER_HEIGHT   ( 20.0f )
#define OTHER_HEADER_HEIGHT   ( 50.0f )

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
      _repositories = repositories;
      _nthRepository = 0;
      _userChanged = NO;
      _allDataSources = [[NSMutableArray alloc] init];
      _slideBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(slideBackCenterView)];
    }
  return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  int index = [_tableView.allTableViews indexOfObject:tableView];
  BCIssueDetailViewController *issueDetailViewController = [[BCIssueDetailViewController alloc] initWithIssue:[self getIssueForIndexPath:indexPath fromNthRepository:index] andController:self];
  [self presentViewController:issueDetailViewController animated:YES completion:nil];
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
  [_tableView setRepoName:[(BCRepository *)[_repositories objectAtIndex:_nthRepository] name]];
  self.view = _tableView;
  
  [self createModel];
  [self getAllCollaborators];
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
  int headerHeight;
  if (section == 0) {
    headerHeight = FIRST_HEADER_HEIGHT;
  }else{
    headerHeight = OTHER_HEADER_HEIGHT;
  }
  int index = [_tableView.allTableViews indexOfObject:tableView];
  BCHeadeView *headerView;
  if ([_allDataSources count] > index) {
    BCIssueDataSource *currentDataSource = [_allDataSources objectAtIndex:index];
    BCIssue *currentIssue = [[currentDataSource.dataSource objectForKey:[currentDataSource.dataSourceKeyNames objectAtIndex:section]] objectAtIndex:0];
    if ([currentIssue.title isEqualToString:NO_ISSUES]) {
      return [[BCHeadeView alloc] init];
    }
    headerView = [[BCHeadeView alloc] initWithFrame:CGRectMake(0, _tableView.navigationBarView.frame.size.height, _tableView.frame.size.width, headerHeight) andMilestone:currentIssue.milestone];
    return headerView;
  }else{
    return [[BCHeadeView alloc] init];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  if (section == 0) {
    return FIRST_HEADER_HEIGHT;
  }
  return OTHER_HEADER_HEIGHT;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  if (scrollView == _tableView.tableViews) {
    int contentOffset = scrollView.contentOffset.x;
    if (contentOffset%(int)self.view.frame.size.width == 0) {
      int originalOffset = _nthRepository*self.view.frame.size.width;
      if (contentOffset != originalOffset) {
        if (contentOffset < originalOffset) {
          _nthRepository--;
          [_tableView setRepoName:[(BCRepository *)[_repositories objectAtIndex:_nthRepository] name]];
          [_tableView animatePaginatorWithCurrentRepoNumber:_nthRepository];
        }else{
          _nthRepository++;
          [_tableView setRepoName:[(BCRepository *)[_repositories objectAtIndex:_nthRepository] name]];
          [_tableView animatePaginatorWithCurrentRepoNumber:_nthRepository];
        }
      }
    }
  }
}

#pragma mark -
#pragma mark buttonActions

- (void)addButtonDidPress{
  BCAddIssueViewController *addIssueVC = [[BCAddIssueViewController alloc] initWithRepository:[_repositories objectAtIndex:_nthRepository] andController:self];
  [self.navigationController pushViewController:addIssueVC animated:YES];
}

-(void)chooseButtonDidPress{
  BCCollaboratorsViewController *chooseCollVC = [[BCCollaboratorsViewController alloc] initWithCollaborators:_allCollaborators andIssueViewCtrl:self];
  [self.view addGestureRecognizer:_slideBack];
  [_tableView.tableViews setUserInteractionEnabled:NO];
  [_tableView.chooseCollaboratorButton setEnabled:NO];
  BCAppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
  [myDelegate.deckController slideCenterControllerToTheRightWithLeftController:chooseCollVC animated:YES withCompletion:nil];
//  [self.navigationController pushViewController:chooseCollVC animated:YES];
}

#pragma mark -
#pragma mark public

-(void)slideBackCenterView{
  BCAppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
  if ([myDelegate.deckController leftControllerPresented] || [myDelegate.deckController rightControllerPresented]) {
    if ([_tableView.chooseCollaboratorButton isEnabled]) {
      [_tableView.addNewIssueButton setEnabled:YES];
    }else{
      [_tableView.chooseCollaboratorButton setEnabled:YES];
    }
    [self.view removeGestureRecognizer:_slideBack];
    [_tableView.tableViews setUserInteractionEnabled:YES];
    [myDelegate.deckController slideCenterControllerBackAnimated:YES withCompletion:nil];
  }
}

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
      if (![issues count]) {
        [issues addObject:[[BCIssue alloc] initNoIssues]];
      }
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

-(void)getAllCollaborators{
  __block int i = 0;
  __block BCRepository *currentRepo = [_repositories objectAtIndex:i];
  __block NSMutableArray *allCollaborators = [[NSMutableArray alloc] init];
  __block void (^myFailureBlock) (NSError *error) = [^(NSError *error) {
    [UIAlertView showWithError:error];
  } copy];
  __block void (^mySuccessBlock) (NSArray *collaborators);
  mySuccessBlock = [^(NSArray *collaborators){
    for (BCUser *newCollaborator in collaborators) {
      BOOL addCollaborator = YES;
      int numberOfCollaborators = [allCollaborators count];
      if (numberOfCollaborators) {
        for (int i = 0; i < numberOfCollaborators; i++){
          BCUser *currentCollaborator = [allCollaborators objectAtIndex:i];
          if ([currentCollaborator.userId isEqualToNumber:newCollaborator.userId]) {
            addCollaborator = NO;
          }
        }
        if (addCollaborator) {
          [allCollaborators addObject:newCollaborator];
        }
      }else{
        [allCollaborators addObject:newCollaborator];
      }
    }
    i++;
    if ([_repositories count] == i) {
      _allCollaborators = allCollaborators;
    }else{
      currentRepo = [_repositories objectAtIndex:i];
      [BCRepository getAllCollaboratorsOfRepository:currentRepo withSuccess:mySuccessBlock failure:myFailureBlock];
    }
  } copy];
  [BCRepository getAllCollaboratorsOfRepository:currentRepo withSuccess:mySuccessBlock failure:myFailureBlock];
}


@end
