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

@implementation BCIssueDetailView

-(id) initWithIssue:(BCIssue *) issue{
    self = [super init];
    if(self){
        [self setBackgroundColor:[UIColor blackColor]];
        _avatar = [[UIImageView alloc] init];
        [_avatar setImageWithURL:issue.assignee.avatarUrl placeholderImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
        
        _assignee = [[UIButton alloc] init];
        [_assignee setTitle:issue.assignee.userLogin forState:UIControlStateNormal];
        //setSelecable !!!
        //[_assignee setText:issue.assignee.userLogin];
        //[_assignee setFont:[UIFont fontWithName:@"arial" size:15]];
        
        _title = [[UITextView alloc] init];
        [_title setEditable:NO];
        [_title setText:issue.title];
        [_title setFont:[UIFont fontWithName:@"arial" size:15]];

        _body = [[UITextField alloc] init];//povolit at muze byt viceradkovy
        [_body setEnabled:NO];
        [_body setText:issue.body];
        [_body setBackgroundColor:[UIColor whiteColor]];
        [_body setFont:[UIFont fontWithName:@"arial" size:15]];
        
        [self addSubview:_avatar];
        [self addSubview:_assignee];
        [self addSubview:_title];
        [self addSubview:_body];        
    }
    return self;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
