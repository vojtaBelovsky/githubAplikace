//
//  BCCollaboratorsView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCCollaboratorsView : UIView

@property (readonly) UITableView *tableView;
@property UIImageView *backgroundImageView;
@property UILabel *repositoryLabel;
@property UILabel *repositoryLabelShadow;
@property UIButton *doneButton;

@end
