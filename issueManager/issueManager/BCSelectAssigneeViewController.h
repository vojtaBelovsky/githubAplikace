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
@protocol BCSelectDataManager;

@interface BCSelectAssigneeViewController : UIViewController<UITableViewDelegate>{
@private
    BCRepository *_repository;
    BCSelectAssigneeView *_BCSelectAssigneView;
    BCSelectAssigneeDataSource *_dataSource;
    UIViewController<BCSelectDataManager> *_controller;
  NSIndexPath *_checkedAssignee;
}

- (id)initWithRepository:(BCRepository *)repository andController:(UIViewController<BCSelectDataManager> *)controller;

@end
