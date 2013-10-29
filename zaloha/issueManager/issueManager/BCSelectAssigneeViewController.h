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
@class BCAddIssueViewController;

@interface BCSelectAssigneeViewController : UIViewController<UITableViewDelegate>{
@private
    BCRepository *_repository;
    BCSelectAssigneeView *_selectAssigneView;
    BCSelectAssigneeDataSource *_dataSource;
    BCAddIssueViewController *_controller;
  NSIndexPath *_checkedAssignee;
}

- (id)initWithController:(BCAddIssueViewController *)controller;

@end
