//
//  BCRepositoryDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryDataSource.h"
#import "BCRepositoryCell.h"
#import "BCUser.h"
#import "BCOrg.h"
#import "BCRepository.h"
#import "BCRepositoryViewController.h"

@implementation BCRepositoryDataSource

- (id)initWithRepositories:(NSArray *)repositories andNavigationController:(BCRepositoryViewController *)repoViewController{
    self = [super init];
    if(self){
      _repositories = repositories;
      _repoViewController = repoViewController;
      _actualSelected = [[NSMutableArray alloc] initWithCapacity:[_repositories count]];
      for(int i = 0; i < [_repositories count]; i++){
        [_actualSelected insertObject:[NSNumber numberWithBool:NO] atIndex:i];
      }
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSUInteger count;
  if(section%2 == 0){
    count = 1;
  }else{
    count = 0;
    if (  [[_actualSelected objectAtIndex:section-1] isEqual:[NSNumber numberWithBool:YES]]  ) {
      count = [[_repositories objectAtIndex:section] count];
    }
  }
  return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//  NSInteger numberOfSections = [_repositories count]/2;
//  int i = 0;
//  for(NSNumber *object in _actualSelected){
//    if(i%2 == 0 && [object integerValue] == 1){
//      numberOfSections++;
//    }
//  }
//  return numberOfSections;
  return [_repositories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  BCRepositoryCell *cell = nil;
  if([indexPath section]%2 == 0)//sudy prvek data sourcu je User nebo Org
  {
    cell = [BCRepositoryCell createOrgOrMyRepositoryCellWithTableView:tableView];
    if([_repositories[indexPath.section][indexPath.row] isKindOfClass:[BCUser class]]){
      BCUser *user = _repositories[indexPath.section][indexPath.row];
      cell.textLabel.text = user.userLogin;
    }else{
      BCOrg *org = _repositories[indexPath.section][indexPath.row];
      cell.textLabel.text = org.orgLogin;
    }
  }else{
    cell = [BCRepositoryCell createRepositoryCellWithTableView:tableView];
    BCRepository *repo = _repositories[indexPath.section][indexPath.row];
    cell.textLabel.text = repo.name;
  }
  return cell;
}

#pragma mark
#pragma mark public

-(NSInteger)getNumberOfRowsToAddToSection:(NSUInteger)section{
  return [_repositories[section] count];
}

-(BCRepository *)getRepositoryAtIndex:(NSUInteger)row{
  return [_repositories objectAtIndex:row];
}

@end
