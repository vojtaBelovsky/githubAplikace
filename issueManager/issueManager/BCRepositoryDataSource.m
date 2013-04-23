//
//  BCRepositoryDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryDataSource.h"
#import "BCRepositoryCell.h"

@implementation BCRepositoryDataSource

- (id)initWithRepositories:(NSArray *)repositories{
    self = [super init];
    if(self){
        _repositories = repositories;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_repositories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[BCRepositoryCell alloc] initWithRepository:[_repositories objectAtIndex:indexPath.row]];
}

@end
