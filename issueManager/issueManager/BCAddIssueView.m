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
        
        _title = [[UITextField alloc] init];
        [_title setEnabled:NO];
        [_title setText:@"Issue title"];
        [_title setFont:[UIFont fontWithName:@"arial" size:15]];
        [_title setReturnKeyType:UIReturnKeyNext];
        [_title setBackgroundColor:[UIColor whiteColor]];
        
        _body = [[UITextView alloc] init];//povolit at muze byt viceradkovy
        [_body setEditable:NO];
        [_body setText:@"Issue description"];
        [_body setFont:[UIFont fontWithName:@"arial" size:15]];
        
        [self addSubview:_avatar];
        [self addSubview:_assignee];
        [self addSubview:_title];
        [self addSubview:_body];
    }
    return self;
}

-(void) rewriteContentWithAssignee:(BCUser *)assignee{
    if(assignee == NULL){
        return;
    }
    [_avatar setImageWithURL:assignee.avatarUrl placeholderImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
    [_assignee setTitle:assignee.userLogin forState:UIControlStateNormal];
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
    
    CGRect bodyFrame = CGRectMake(0, 82, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-82);
    if(!CGRectEqualToRect(_body.frame, bodyFrame)){
        _body.frame = bodyFrame;
    }
    
}

@end
