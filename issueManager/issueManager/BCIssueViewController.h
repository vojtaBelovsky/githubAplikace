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
    BCRepository *_repository;
    BCIssueView *_tableView;
    BCIssueDataSource *_dataSource;
}

- (id) initWithRepository:(BCRepository *)repository;

-(void)addNewIssue:(BCIssue *)newIssue;
-(void)changeIssue:(BCIssue *)issue;

@end
