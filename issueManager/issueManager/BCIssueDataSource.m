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
#import "BCProfileIssue.h"

@implementation BCIssueDataSource

-(id) initWithIssues:(NSMutableArray *)issues andMilestones:(NSMutableArray *)milestones{
  self = [super init];
  if(self){
    _issues = issues;
    _milestones = milestones;
  }
  return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//  return _milestones.count+1;
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_issues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  BCIssueCell *cell;
  cell = [BCIssueCell createIssueCellWithTableView:tableView];
  BCIssue *issueForRow = [_issues objectAtIndex:indexPath.row];
  [cell.profileIssue setWithIssue:issueForRow];
  
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
