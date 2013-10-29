//
//  BCSelectLabelsViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCRepository;
@class BCSelectLabelsView;
@class BCSelectLabelsDataSource;
@class BCAddIssueViewController;

@interface BCSelectLabelsViewController : UIViewController<UITableViewDelegate>{
@private
    BCRepository *_repository;
    BCSelectLabelsView *_BCSelectLabelsView;
    BCSelectLabelsDataSource *_dataSource;
    BCAddIssueViewController *_controller;
  NSMutableArray *_checkedLabels; //array of NSIndexPath of selected labels
}

- (id)initWithController:(BCAddIssueViewController *)controller;

@end
