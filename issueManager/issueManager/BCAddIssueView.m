//
//  BCAddIssueView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCAddIssueView.h"
#import "BCAddIssueViewController.h"
#import "BCUser.h"
#import "UIImageView+AFNetworking.h"
#import "BCMilestone.h"
#import "BCLabel.h"

@implementation BCAddIssueView

-(id) initWithController:(BCAddIssueViewController *)controller{
    self = [super init];
    if(self){
        [self setBackgroundColor:[UIColor blackColor]];
        _avatar = [[UIImageView alloc] init];
        [_avatar setImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
        
        _assignee = [[UIButton alloc] init];
        [_assignee setTitle:@"nobody is assigned" forState:UIControlStateNormal];
        [_assignee addTarget:controller action:@selector(selectAssignee) forControlEvents:UIControlEventTouchDown];
        [_assignee setEnabled:NO];
        
        _milestone = [[UIButton alloc] init];
        [_milestone setTitle:@"no milestone is assigned" forState:UIControlStateNormal];
        [_milestone addTarget:controller action:@selector(selectLabel) forControlEvents:UIControlEventTouchDown];
        [_milestone setBackgroundColor:[UIColor whiteColor]];
        [_milestone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_milestone setEnabled:NO];
        
        _title = [[UITextField alloc] init];
        [_title setEnabled:NO];
        [_title setText:@"New issue title"];
        [_title setFont:[UIFont fontWithName:@"arial" size:20]];
        [_title setReturnKeyType:UIReturnKeyNext];
        [_title setBackgroundColor:[UIColor whiteColor]];
        [_title setTextAlignment:NSTextAlignmentCenter];
        [_title setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        _body = [[UITextView alloc] init];
        [_body setEditable:NO];
        [_body setText:@"Issue description"];
        [_body setFont:[UIFont fontWithName:@"arial" size:15]];
        
        
        
        _labels = [[UITextView alloc] init];
        [_labels setText:@"no label is assigned"];
        //[_labels setBackgroundColor:[UIColor whiteColor]];
        //[_labels setTextColor:[UIColor blackColor]];
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

-(void) rewriteContentWithAssignee:(BCUser *)assignee milestone:(BCMilestone *)milestone andLabels:(NSArray *)labels{
    if(assignee.userId != 0){
        [_avatar setImageWithURL:assignee.avatarUrl placeholderImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
        [_assignee setTitle:assignee.userLogin forState:UIControlStateNormal];
        [_assignee setBackgroundColor:[UIColor whiteColor]];
        [_assignee setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_avatar setImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
        [_assignee setTitle:@"nobody is assigned" forState:UIControlStateNormal];
        [_assignee setBackgroundColor:[UIColor grayColor]];
        [_assignee setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    if(milestone.number != 0){
        [_milestone setTitle:milestone.title forState:UIControlStateNormal];
        [_milestone setBackgroundColor:[UIColor whiteColor]];
        [_milestone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_milestone setTitle:@"no milestone is assigned" forState:UIControlStateNormal];
        [_milestone setBackgroundColor:[UIColor grayColor]];
        [_milestone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    if(labels.count != 0){
        NSMutableString *labelsInString = [[NSMutableString alloc] init];
        for(BCLabel *object in labels){
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
