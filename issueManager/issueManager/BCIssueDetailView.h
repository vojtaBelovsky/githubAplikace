//
//  BCIssueDetailView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/26/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCIssue;

@interface BCIssueDetailView : UIView

@property UIImageView *avatar;
@property UIButton *assignee;
@property UITextView *title;
@property UITextField *body;

-(id) initWithIssue:(BCIssue *) issue;


@end
