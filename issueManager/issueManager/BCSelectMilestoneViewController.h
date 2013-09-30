//
//  BCSelectMilestoneViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCSelectMilestoneDataSource;
@class BCSelectMilestoneView;
@class BCAddIssueViewController;
@class BCMilestone;

@interface BCSelectMilestoneViewController : UIViewController<UITableViewDelegate>{
@private
  BCSelectMilestoneView *_selectMilestoneView;
  BCSelectMilestoneDataSource *_dataSource;
  BCAddIssueViewController *_controller;
  NSIndexPath *_checkedMilestone;
}

- (id)initWithController:(BCAddIssueViewController *)controller;


@end
