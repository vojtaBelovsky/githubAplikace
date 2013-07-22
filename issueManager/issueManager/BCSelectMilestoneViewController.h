//
//  BCSelectMilestoneViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCRepository;
@class BCSelectMilestoneDataSource;
@class BCSelectMilestoneView;
@class BCIssueDetailViewController;
@class BCUser;
@protocol BCSelectDataManager;

@interface BCSelectMilestoneViewController : UIViewController<UITableViewDelegate>{
@private
    BCRepository *_repository;
    BCSelectMilestoneView *_selectMilestoneView;
    BCSelectMilestoneDataSource *_dataSource;
    UIViewController<BCSelectDataManager> *_controller;
    NSIndexPath *_checkedMilestone;
}

- (id)initWithRepository:(BCRepository *)repository andController:(UIViewController<BCSelectDataManager> *)controller;


@end
