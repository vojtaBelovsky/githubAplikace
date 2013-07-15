//
//  BCIssueView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCIssueView : UIView

@property UIImageView *backgroundImageView;
@property UITableView *tableView;
@property UIView *navigationBarView;
@property UIButton *chooseCollaboratorButton;
@property UIButton *addNewIssueButton;
@property UILabel *userNameLabel;
@property UILabel *userNameShadowLabel;

-(id)initWithUserName:(NSString *)userName;

@end
