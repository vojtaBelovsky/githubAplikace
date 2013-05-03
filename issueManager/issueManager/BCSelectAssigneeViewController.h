//
//  BCSelectAssigneeViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCRepository;
@class BCSelectAssigneeDataSource;
@class BCSelectAssigneeView;
@class BCIssueDetailViewController;
@class BCUser;
@protocol BCManageIssue;

@interface BCSelectAssigneeViewController : UIViewController<UITableViewDelegate>{
@private
    BCRepository *_repository;
    BCSelectAssigneeView *_tableView;
    BCSelectAssigneeDataSource *_dataSource;
    UIViewController<BCManageIssue> *_controller;
}

- (id)initWithRepository:(BCRepository *)repository andController:(BCIssueDetailViewController *)controller;

@end
