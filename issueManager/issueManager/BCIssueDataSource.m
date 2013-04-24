//
//  BCIssueDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueDataSource.h"
#import "BCIssueCell.h"

@implementation BCIssueDataSource

-(id) initWithIssues:(NSArray *)issues{
    self = [super init];
    if(self){
        _issues = issues;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_issues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[BCIssueCell alloc] initWithIssue:[_issues objectAtIndex:indexPath.row]];
}

@end
