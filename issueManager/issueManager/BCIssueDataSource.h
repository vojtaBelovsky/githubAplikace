//
//  BCIssueDataSource.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#define WITHOUT_MILESTONE @"Without milestone"

#import <Foundation/Foundation.h>
@class BCIssue;

@interface BCIssueDataSource : NSObject<UITableViewDataSource>

@property NSMutableDictionary *dataSource;
@property NSMutableArray *dataSourceKeyNames;

-(id) initWithIssues:(NSMutableArray *)issues milestones:(NSMutableArray *)milestones;

-(void)addNewIssue:(BCIssue *)newIssue;
-(void)changeIssue:(BCIssue *)issue forNewIssue:(BCIssue *)newIssue;
-(void)removeIssue:(BCIssue *)issue;

@end
