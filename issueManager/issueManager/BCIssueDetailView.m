//
//  BCIssueDetailView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/26/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueDetailView.h"
#import "BCIssue.h"
#import "UIImageView+AFNetworking.h"
#import "BCUser.h"
#import "BCIssueDetailViewController.h"
#import "BCLabel.h"
#import "BCMilestone.h"

@implementation BCIssueDetailView

-(id) initWithIssue:(BCIssue *)issue andController:(BCIssueDetailViewController *)controller{
    self = [super init];
    if(self){
        [self setBackgroundColor:[UIColor blackColor]];
        _avatar = [[UIImageView alloc] init];
        
        _assignee = [[UIButton alloc] init];
        [_assignee addTarget:controller action:@selector(selectAssignee) forControlEvents:UIControlEventTouchDown];
        [_assignee setEnabled:NO];
        
        _milestone = [[UIButton alloc] init];
        [_milestone addTarget:controller action:@selector(selectLabel) forControlEvents:UIControlEventTouchDown];
        [_milestone setEnabled:NO];
        
        _title = [[UITextField alloc] init];
        [_title setEnabled:NO];
        [_title setText:issue.title];
        [_title setFont:[UIFont fontWithName:@"arial" size:20]];
        [_title setReturnKeyType:UIReturnKeyNext];
        [_title setBackgroundColor:[UIColor whiteColor]];
        [_title setTextAlignment:NSTextAlignmentCenter];
        [_title setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];

        _body = [[UITextView alloc] init];
        [_body setEditable:NO];
        [_body setText:issue.body];
        [_body setFont:[UIFont fontWithName:@"arial" size:15]];
        
        _labels = [[UITextView alloc] init];
        [_labels setText:@"no label is assigned"];
        [_labels setEditable:NO];
        
        _labelsButton = [[UIButton alloc] init];
        [_labelsButton setEnabled:NO];
        [_labelsButton addTarget:controller action:@selector(selectLabels) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:_avatar];
        [self addSubview:_assignee];
        [self addSubview:_milestone];
        [self addSubview:_title];
        [self addSubview:_body];
        [self addSubview:_labels];
        [self addSubview:_labelsButton];
    }
    return self;
}

-(void) rewriteContentWithIssue:(BCIssue *)issue{
    if(issue.assignee.userId != 0){
        [_avatar setImageWithURL:issue.assignee.avatarUrl placeholderImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
        [_assignee setTitle:issue.assignee.userLogin forState:UIControlStateNormal];
        [_assignee setBackgroundColor:[UIColor whiteColor]];
        [_assignee setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_avatar setImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
        [_assignee setTitle:@"nobody is assigned" forState:UIControlStateNormal];
        [_assignee setBackgroundColor:[UIColor grayColor]];
        [_assignee setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    if(issue.milestone.number != 0){
        [_milestone setTitle:issue.milestone.title forState:UIControlStateNormal];
        [_milestone setBackgroundColor:[UIColor whiteColor]];
        [_milestone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_milestone setTitle:@"no milestone is assigned" forState:UIControlStateNormal];
        [_milestone setBackgroundColor:[UIColor grayColor]];
        [_milestone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    if(issue.labels.count != 0){
        NSMutableString *labelsInString = [[NSMutableString alloc] init];
        for(BCLabel *object in issue.labels){
            [labelsInString insertString:object.name atIndex:[labelsInString length]];
            [labelsInString insertString:@" " atIndex:[labelsInString length]];
        }
        [_labels setText:labelsInString];
        [_labels setBackgroundColor:[UIColor whiteColor]];
        [_labels setTextColor:[UIColor blackColor]];
    }else{
        [_labels setText:@"no label is assigned"];
        [_labels setBackgroundColor:[UIColor grayColor]];
        [_labels setTextColor:[UIColor whiteColor]];
    }
    [_avatar setImageWithURL:issue.assignee.avatarUrl placeholderImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
    [_assignee setTitle:issue.assignee.userLogin forState:UIControlStateNormal];
    [_title setText:issue.title];
    [_body setText:issue.body];
}

-(void) layoutSubviews{
    [super layoutSubviews];
    
    CGRect titleFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 40);
    if(!CGRectEqualToRect(_title.frame, titleFrame)){
        _title.frame = titleFrame;
    }
    
    CGRect avatarFrame = CGRectMake(0, 41, 40, 40);
    if(!CGRectEqualToRect(_avatar.frame, avatarFrame)){
        _avatar.frame = avatarFrame;
    }
    
    CGRect assigneeFrame = CGRectMake(41, 41, CGRectGetWidth(self.frame) - 41, 40);
    if(!CGRectEqualToRect(_assignee.frame, assigneeFrame)){
        _assignee.frame = assigneeFrame;
    }
    
    CGRect milestoneFrame = CGRectMake(0, 82, CGRectGetWidth(self.frame), 40);
    if(!CGRectEqualToRect(_milestone.frame, milestoneFrame)){
        _milestone.frame = milestoneFrame;
    }
    
    CGRect bodyFrame = CGRectMake(0, 123, CGRectGetWidth(self.frame), 240);
    if(!CGRectEqualToRect(_body.frame, bodyFrame)){
        _body.frame = bodyFrame;
    }
    
    
    CGRect labelsFrame = CGRectMake(0, 364, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 364);
    if(!CGRectEqualToRect(_labels.frame, labelsFrame)){
        _labels.frame = labelsFrame;
    }
    
    CGRect labelsButtonFrame = CGRectMake(0, 364, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 364);
    if(!CGRectEqualToRect(_labelsButton.frame, labelsButtonFrame)){
        _labelsButton.frame = labelsButtonFrame;
    }
}

@end
