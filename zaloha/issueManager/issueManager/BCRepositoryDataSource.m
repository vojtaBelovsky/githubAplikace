//
//  BCRepositoryDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryDataSource.h"
#import "BCUser.h"
#import "BCOrg.h"
#import "BCRepository.h"
#import "BCRepositoryViewController.h"
#import "BCUsrOrgCell.h"
#import "BCRepoCell.h"
#import "BCNoRepoCell.h"
#import "BCAvatarImgView.h"
#import "UIImageView+AFNetworking.h"

#define PLACEHOLDER_IMG     [UIImage imageNamed:@"gravatar-user-420.png"]

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
    NSString * keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(section)], KEY_REPOSITORIES ];
    return ([[_repositories valueForKeyPath:keyPath] count]+1);
  }
  return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return [_repositories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = nil;
  if (indexPath.row == 0) {
    BCUsrOrgCell *usrOrgCell;
    NSString * keyPath = [NSString stringWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(indexPath.section)], KEY_OBJECT];
    id object = [_repositories valueForKeyPath:keyPath];
    if ([object isKindOfClass:[BCUser class]]) {
      keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(indexPath.section)], KEY_IMAGE_URL ];
      usrOrgCell = [BCUsrOrgCell createOrgOrUserRepositoryCellWithTableView:tableView];
      usrOrgCell.myTextLabel.text = [(BCUser *)object userLogin];
      [usrOrgCell.avatar setImageWithURL:[_repositories valueForKeyPath:keyPath] placeholderImage:PLACEHOLDER_IMG];
    }else{
      keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(indexPath.section)], KEY_IMAGE_URL ];
      usrOrgCell = [BCUsrOrgCell createOrgOrUserRepositoryCellWithTableView:tableView];
      usrOrgCell.myTextLabel.text = [(BCOrg *)object orgLogin];
      [usrOrgCell.avatar setImageWithURL:[_repositories valueForKeyPath:keyPath] placeholderImage:PLACEHOLDER_IMG];
    }
    cell = usrOrgCell;
  }else{
    NSString *keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(indexPath.section)], KEY_REPOSITORIES ];
    BCRepository *repo = [(NSArray *)[_repositories valueForKeyPath:keyPath] objectAtIndex:(indexPath.row-1)];
    if ([repo.name isEqualToString:NO_REPOSITORIES]) {
      BCNoRepoCell *noRepoCell = [BCNoRepoCell createNoRepoCellWithTableView:tableView];
      noRepoCell.myTextLabel.text = repo.name;
      cell = noRepoCell;
    }else{
      BCRepoCell *repoCell = [BCRepoCell createRepositoryCellWithTableView:tableView];
      repoCell.myTextLabel.text = repo.name;
      cell = repoCell;
    }
  }
  return cell;
}

#pragma mark
#pragma mark public

-(NSInteger)getNumberOfRowsToAddToSection:(NSUInteger)section{
  NSString * keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(section)], KEY_REPOSITORIES ];
  int count = [[_repositories valueForKeyPath:keyPath] count];
  if (count) {
    return count;
  }else{
    return 1;//NO REPOSITORY cell
  }
}

-(BCRepository *)getRepositoryAtIndex:(NSIndexPath *)indexPath{
  NSString *keyPath = [[NSString alloc] initWithFormat:@"%@.%@", (NSString *)[_keyNames objectAtIndex:(indexPath.section)], KEY_REPOSITORIES ];
  BCRepository *repo = [(NSArray *)[_repositories valueForKeyPath:keyPath] objectAtIndex:(indexPath.row-1)];
  return repo;
}

@end
