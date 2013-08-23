//
//  BCCollaboratorsViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCCollaboratorsDataSource;
@class BCCollaboratorsView;
@class BCIssueViewController;

@interface BCCollaboratorsViewController : UIViewController<UITableViewDelegate>

@property NSArray *repositories;
@property BCCollaboratorsDataSource *dataSource;
@property BCCollaboratorsView *tableView;
@property BCIssueViewController* issueViewCtrl;

- (id)initWithRepositories:(NSArray *)repositories andIssueViewCtrl:(BCIssueViewController *)issueViewCtrl;

@end
