//
//  BCSelectMilestoneView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCSelectMilestoneView : UIView

@property (strong) UITableView *tableView;
@property UIImageView *backgroundImageView;
@property UIView *navigationBarView;
@property UIButton *cancelButton;
@property UIButton *doneButton;
@property UILabel *theNewIssueLabel;
@property UILabel *theNewIssueShadowLabel;
@property UIImageView *form;

@end
