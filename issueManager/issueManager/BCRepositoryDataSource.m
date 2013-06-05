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

@implementation BCRepositoryDataSource

- (id)initWithRepositories:(NSArray *)repositories{
    self = [super init];
    if(self){
        _repositories = repositories;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_repositories[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BCRepositoryCell *cell = nil;
    
    if(indexPath.row == 0)//kdyz je radek 0, mame usera nebo org
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

-(BCRepository *)getRepositoryAtIndex:(NSUInteger)row{
    return [_repositories objectAtIndex:row];
}

@end
