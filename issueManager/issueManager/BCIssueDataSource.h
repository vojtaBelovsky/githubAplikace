//
//  BCIssueDataSource.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BCIssue;

@interface BCIssueDataSource : NSObject<UITableViewDataSource>

@property (copy) NSMutableArray *issues;

-(id) initWithIssues:(NSMutableArray *)issues;

-(void)addNewIssue:(BCIssue *)newIssue;
-(void)changeIssue:(BCIssue *)issue atIndex:(NSUInteger)index;


@end
