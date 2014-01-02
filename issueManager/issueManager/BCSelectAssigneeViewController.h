//
//  BCSelectAssigneeViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCSelectAssigneeDataSource;
@class BCSelectAssigneeView;
@class BCIssueDetailViewController;
@class BCAddIssueViewController;

@interface BCSelectAssigneeViewController : UIViewController<UITableViewDelegate>{
@private
  BCSelectAssigneeView *_selectAssigneView;
  BCSelectAssigneeDataSource *_dataSource;
  BCAddIssueViewController *_controller;
  NSIndexPath *_checkedAssignee;
}

- (id)initWithController:(BCAddIssueViewController *)controller;

@end
