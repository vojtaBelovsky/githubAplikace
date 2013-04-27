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
        _issue = issue;
        
        _avatar = [[UIImageView alloc] init];
        [_avatar setImageWithURL:_issue.assignee.avatarUrl placeholderImage:[UIImage imageNamed:@"gravatar-user-420.png"]];
        
        _assignee = [[UILabel alloc] init];
        [_assignee setText:_issue.assignee.userLogin];
        [_assignee setFont:[UIFont fontWithName:@"arial" size:15]];
        
        _title = [[UITextView alloc] init];
        [_title setText:_issue.title];
        [_title setFont:[UIFont fontWithName:@"arial" size:15]];

        _body = [[UITextField alloc] init];
        [_body setText:_issue.body];
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
    
    CGRect titleFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 60);
    if(CGRectEqualToRect(_title.frame, titleFrame)){
        _title.frame = titleFrame;
    }
    
    CGRect avatarFrame = CGRectMake(0, 60, 60, 60);
    if(CGRectEqualToRect(_avatar.frame, avatarFrame)){
        _avatar.frame = avatarFrame;
    }
    
    CGRect assigneeFrame = CGRectMake(60, 60, CGRectGetWidth(self.frame) - 60, 60);
    if(CGRectEqualToRect(_assignee.frame, assigneeFrame)){
        _assignee.frame = assigneeFrame;
    }
    
    CGRect bodyFrame = CGRectMake(0, 120, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-120);
    if(CGRectEqualToRect(_body.frame, bodyFrame)){
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
