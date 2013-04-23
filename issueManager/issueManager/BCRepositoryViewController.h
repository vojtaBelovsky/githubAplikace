//
//  BCRepositoryViewController.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 4/19/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

@class BCRepositoryView;
@class BCRepositoryDataSource;

@interface BCRepositoryViewController : UIViewController<UITableViewDelegate> {
@private
    BCRepositoryView *_repoView;
    BCRepositoryDataSource *_dataSource;
}

@end
