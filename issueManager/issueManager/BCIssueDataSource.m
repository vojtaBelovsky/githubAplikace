//
//  BCIssueDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueDataSource.h"
#import "BCIssueCell.h"
#import "BCIssue.h"

@implementation BCIssueDataSource

-(id) initWithIssues:(NSMutableArray *)issues{
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
    BCIssueCell *cell;
    cell = [BCIssueCell createIssueCellWithTableView:tableView];
    BCIssue *issueForRow = [_issues objectAtIndex:indexPath.row];
    cell.textLabel.text = issueForRow.title;
    [cell.textLabel setFont:[UIFont fontWithName:@"arial" size:15]];
    return cell;
}

#pragma mark -
#pragma mark public

-(void)addNewIssue:(BCIssue *)newIssue{
    [_issues insertObject:newIssue atIndex:0];
}

-(void)changeIssue:(BCIssue *)issue atIndex:(NSUInteger)index{
    [_issues replaceObjectAtIndex:index withObject:issue];
}



@end
