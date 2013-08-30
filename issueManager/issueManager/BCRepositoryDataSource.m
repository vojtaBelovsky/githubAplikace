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

- (id)initWithRepositories:(NSDictionary *)repositories repositoryNames:(NSArray *) keyNames andNavigationController:(BCRepositoryViewController *)repoViewController{
    self = [super init];
    if(self){
      _repositories = repositories;
      _keyNames = keyNames;
      _repoViewController = repoViewController;
      _actualSelected = [[NSMutableArray alloc] initWithCapacity:[_repositories count]];
      for(int i = 0; i < [_repositories count]; i++){
        [_actualSelected insertObject:[NSNumber numberWithBool:NO] atIndex:i];
      }
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSUInteger count = 1;
  if ([[_actualSelected objectAtIndex:(section)] isEqual:[NSNumber numberWithBool:YES]]) {
    NSString * keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(section)], @"repositories" ];
    return ([[_repositories valueForKeyPath:keyPath] count]+1);
  }
  return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return [_repositories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  BCRepositoryCell *cell = nil;
  if (indexPath.row == 0) {
    NSString * keyPath = [NSString stringWithFormat:@"%@.object", (NSString *)[_keyNames objectAtIndex:(indexPath.section)]];
    id object = [_repositories valueForKeyPath:keyPath];
    if ([object isKindOfClass:[BCUser class]]) {
      keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(indexPath.section)], @"image" ];
      cell = [BCRepositoryCell createOrgOrUserRepositoryCellWithTableView:tableView WithImg:(UIImage *)[_repositories valueForKeyPath:keyPath]];
      cell.myTextLabel.text = [(BCUser *)object userLogin];
    }else{
      keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(indexPath.section)], @"image" ];
      cell = [BCRepositoryCell createOrgOrUserRepositoryCellWithTableView:tableView WithImg:(UIImage *)[_repositories valueForKeyPath:keyPath]];
      cell.myTextLabel.text = [(BCOrg *)object orgLogin];
    }
  }else{
    NSString *keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(indexPath.section)], @"repositories" ];
    BCRepository *repo = [(NSArray *)[_repositories valueForKeyPath:keyPath] objectAtIndex:(indexPath.row-1)];
    if ([repo.name isEqualToString:NO_REPOSITORIES]) {
      cell = [BCRepositoryCell createNoRepoCellWithTableView:tableView];
    }else{
      cell = [BCRepositoryCell createRepositoryCellWithTableView:tableView]; 
    }
    cell.myTextLabel.text = repo.name;
  }
  
  return cell;
}

#pragma mark
#pragma mark public

-(NSInteger)getNumberOfRowsToAddToSection:(NSUInteger)section{
  NSString * keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(section)], @"repositories" ];
  int count = [[_repositories valueForKeyPath:keyPath] count];
  if (count) {
    return count;
  }else{
    return 1;//NO REPOSITORY cell
  }
}

-(BCRepository *)getRepositoryAtIndex:(NSIndexPath *)indexPath{
  NSString *keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(indexPath.section)], @"repositories" ];
  BCRepository *repo = [(NSArray *)[_repositories valueForKeyPath:keyPath] objectAtIndex:(indexPath.row-1)];
  return repo;
}

@end
