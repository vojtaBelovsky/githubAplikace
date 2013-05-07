//
//  BCSelectLabelsViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCSelectDataManager.h"
@class BCRepository;
@class BCSelectLabelsView;
@class BCSelectLabelsDataSource;


@interface BCSelectLabelsViewController : UIViewController<UITableViewDelegate>{
@private
    BCRepository *_repository;
    BCSelectLabelsView *_tableView;
    BCSelectLabelsDataSource *_dataSource;
    UIViewController<BCSelectDataManager> *_controller;
}

- (id)initWithRepository:(BCRepository *)repository andController:(UIViewController<BCSelectDataManager> *)controller;


@end
