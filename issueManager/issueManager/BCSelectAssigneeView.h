//
//  BCSelectAssigneeView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCSelectAssigneeView : UIView

@property UITableView *tableView;
@property UIImageView *backgroundImageView;
@property UIView *navigationBarView;
@property UIButton *cancelButton;
@property UIButton *doneButton;
@property UILabel *theNewIssueLabel;
@property UIImageView *form;

@end
