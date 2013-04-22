//
//  BCRepositoryDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryDataSource.h"
#import "BCRepository.h"

@implementation BCRepositoryDataSource

- (id)initWithRepositories:(NSArray *)repositories{
    self = [super init];
    if(self){
        _repositories = repositories;
    }
    return self;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

@end
