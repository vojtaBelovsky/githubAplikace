//
//  BCIssueViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCRepository;
@class BCIssue;
@class BCIssueView;
@class BCIssueDataSource;

@interface BCIssueViewController : UIViewController<UITableViewDelegate>{
@private
    NSArray *_repositories;
    BCIssueView *_tableView;
    BCIssueDataSource *_dataSource;
  NSNumber *_nthRepository;
}

- (id) initWithRepositories:(NSArray *)repositories;

-(void)addNewIssue:(BCIssue *)newIssue;
-(void)changeIssue:(BCIssue *)issue;

@end
