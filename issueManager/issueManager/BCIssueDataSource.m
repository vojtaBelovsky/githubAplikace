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
#import "BCSingleIssueView.h"
#import "BCMilestone.h"

@implementation BCIssueDataSource

-(id) initWithIssues:(NSMutableArray *)issues milestones:(NSMutableArray *)milestones{
  self = [super init];
  if(self){
    _dataSourceKeyNames = [[NSMutableArray alloc] init];
    _dataSource = [[NSMutableDictionary alloc] init];
    
    //creating of sections
    for (BCMilestone *milestone in milestones) {
      [self setDatasourcePairWithKeyName:milestone.title];
    }
    [self setDatasourcePairWithKeyName:WITHOUT_MILESTONE];
    
    //filling sections with data
    for (BCIssue *issue in issues) {
      if ([milestones containsObject:issue.milestone]) {
        [(NSMutableArray *)[_dataSource objectForKey:issue.milestone.title] addObject:issue];
      }else{
        [(NSMutableArray *)[_dataSource objectForKey:WITHOUT_MILESTONE] addObject:issue];
      }
    }
    
    //removing empty sections
    int count = [_dataSourceKeyNames count];
    for (int i = count-1; i >= 0; i--) {
      NSString *keyName = [_dataSourceKeyNames objectAtIndex:i];
      if (![[_dataSource objectForKey:keyName] count]) {
        [_dataSource removeObjectForKey:keyName];
        [_dataSourceKeyNames removeObject:keyName];
      }
    }
  }
  return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [_dataSourceKeyNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray*)[_dataSource objectForKey:[_dataSourceKeyNames objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  BCIssueCell *cell;
  BCIssue *issueForRow = [(NSArray*)[_dataSource objectForKey:[_dataSourceKeyNames objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
  if ([issueForRow.title isEqualToString:NO_ISSUES]) {
    cell = [BCIssueCell createNoIssuesCellWithTableView:tableView];
  }else{
    cell = [BCIssueCell createIssueCellWithTableView:tableView offset:OFFSET font:TITLE_FONT];
    [cell.issueView setWithIssue:issueForRow];
  }
  return cell;
}

#pragma mark - private

-(void)setDatasourcePairWithKeyName:(NSString *)keyName{
  NSMutableArray *dataSourceIssues = [[NSMutableArray alloc] init];
  [_dataSourceKeyNames addObject:keyName];
  [_dataSource setValue:dataSourceIssues forKey:[_dataSourceKeyNames lastObject]];
}

-(void)addNewMilstone:(NSString *)milestoneName withIssue:(BCIssue *)issue{
  NSMutableArray *dataSourceIssues = [[NSMutableArray alloc] initWithObjects:issue, nil];
  if ([milestoneName isEqualToString:WITHOUT_MILESTONE]) {
    //if issue has no milestone and is only one, I will create new section and put it
    //at the end of the table
    [_dataSourceKeyNames addObject:milestoneName];
  }else{
    [_dataSourceKeyNames insertObject:milestoneName atIndex:0];
  }
  [_dataSource setValue:dataSourceIssues forKey:milestoneName];
}

#pragma mark -
#pragma mark public

-(void)removeIssue:(BCIssue *)issue{
  NSMutableArray *currentArray = [_dataSource objectForKey:issue.milestone.title];
  [currentArray removeObject:issue];
  if (![currentArray count]) {
    [_dataSourceKeyNames removeObject:issue.milestone.title];
  }
}

-(void)addNewIssue:(BCIssue *)newIssue{
  if (newIssue.milestone == nil) {
    if ([_dataSourceKeyNames containsObject:WITHOUT_MILESTONE]) {
      [(NSMutableArray *)[_dataSource objectForKey:WITHOUT_MILESTONE] addObject:newIssue];
    }else{
      [self addNewMilstone:WITHOUT_MILESTONE withIssue:newIssue];
    }
  }else{
    if ([_dataSourceKeyNames containsObject:newIssue.milestone.title]) {
      [(NSMutableArray *)[_dataSource objectForKey:newIssue.milestone.title] insertObject:newIssue atIndex:0];
    }else{//its neccesery to add new milestone to data source
      [self addNewMilstone:newIssue.title withIssue:newIssue];
    }
  }
}

-(void)changeIssue:(BCIssue *)issue forNewIssue:(BCIssue *)newIssue {
  if ([issue.milestone isEqual:newIssue.milestone]) {
    NSMutableArray *currentArray = [_dataSource objectForKey:issue.milestone.title];
    NSUInteger index = [currentArray indexOfObject:issue];
    [currentArray replaceObjectAtIndex:index withObject:newIssue];
  }else{
    [self removeIssue:issue];
    if ([_dataSourceKeyNames containsObject:newIssue.milestone.title]) {
      NSMutableArray *currentArray = [_dataSource objectForKey:newIssue.milestone.title];
      [currentArray insertObject:newIssue atIndex:0];
    }else{
      [self addNewMilstone:newIssue.milestone.title withIssue:newIssue];
    }
  }
}



@end
