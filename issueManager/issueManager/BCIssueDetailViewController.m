//
//  BCIssueDetailViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/26/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueDetailViewController.h"
#import "BCIssueDetailView.h"
#import "BCIssue.h"
#import "BCSelectAssigneeViewController.h"
#import "BCHTTPClient.h"
#import "BCRepository.h"
#import "BCUser.h"
#import "BCMilestone.h"
#import "UIAlertView+errorAlert.h"

@interface BCIssueDetailViewController ()

@end

@implementation BCIssueDetailViewController

- (id)initWithIssue:(BCIssue *)issue
{
    self = [super init];
    if (self) {
        _issue = issue;
        _editedIssue = [issue copy]; //ZKUSIT JETLI POTREBUJU HLUBOKOU KOPII!!!
        _cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonAction)];
        _editButton = [self editButtonItem];
        [_editButton setTarget:self];
        [_editButton setAction:@selector(editButtionAction)];
        _buttons = [[NSMutableArray alloc] initWithObjects:_editButton, nil];
        if(_issue.assignee == nil){
            _isSetedAssignee = NO;
        }else{
            _isSetedAssignee = YES;
        }
    }
    return self;
}

-(void) loadView{
    [super loadView];
    _issueDetailview = [[BCIssueDetailView alloc] initWithIssue:_issue andController:self];
    [_issueDetailview.title setDelegate:self];
    [_issueDetailview.body setDelegate:self];
    self.view = _issueDetailview;
    self.navigationItem.rightBarButtonItems = _buttons;
}

-(void) viewWillAppear:(BOOL)animated{
    if([self isEditing]){
        [_issueDetailview rewriteContentWithIssue:_editedIssue];
    }
}

#pragma mark -
#pragma mark ButtonActions

-(void) selectAssignee{
    [self createAndPushSelectAssigneVC];
}

-(void) editButtionAction{
    if([self isEditing]){
        [self setEditing:NO];
        NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues/%d", _issue.repository.owner.userLogin, _issue.repository.name, [_issue.number intValue]];
        [[BCHTTPClient sharedInstance] patchPath:path parameters:[self createParameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Issue was updated");
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [UIAlertView showWithError:error];
        }];
        
    }else{
        [self setEditing:YES];
        [self setItemsEditable:YES];
        [_buttons addObject:_cancelButton];
        self.navigationItem.rightBarButtonItems = _buttons;
        [_issueDetailview.title becomeFirstResponder];
    }
}

-(void) cancelButtonAction{
    [self setItemsEditable:NO];
    [self setEditing:NO];
    [_buttons removeObject:_cancelButton];
    self.navigationItem.rightBarButtonItems = _buttons;
    [_issueDetailview rewriteContentWithIssue:_issue];
}

#pragma mark -
#pragma mark delegateMethods

- (void)textViewDidEndEditing:(UITextView *)textView{
    [_editedIssue setBody:textView.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_editedIssue setTitle:textField.text];
    [self createAndPushSelectAssigneVC];
    return YES;
}

#pragma mark -
#pragma mark private

-(void)createAndPushSelectAssigneVC{
    BCSelectAssigneeViewController *selectAssigneeVC = [[BCSelectAssigneeViewController alloc] initWithRepository:_issue.repository andController:self];
    [self.navigationController pushViewController:selectAssigneeVC animated:YES];
}

-(void)setItemsEditable:(BOOL)isEditable{
    [_issueDetailview.body setEditable:isEditable];
    [_issueDetailview.title setEnabled:isEditable];
    [_issueDetailview.assignee setEnabled:isEditable];
}

-(NSDictionary *) createParameters{    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _editedIssue.title ?: [NSNull null], @"title",
                                _editedIssue.body ?: [NSNull null], @"body",
                                _editedIssue.assignee.userLogin ?: [NSNull null], @"assignee",
                                (_editedIssue.state == GHIssueStateOpen) ? @"open" : @"closed", @"state",
                                _editedIssue.milestone.number ?: [NSNull null], @"milestone",
                                ([_issue getLabelsAsStrings]) ?: [NSNull null], @"labels",
                                nil];
    return parameters;
}

#pragma mark -
#pragma mark public

-(void) setNewAssignee:(BCUser *)assignee{
    [_editedIssue setAssignee:assignee];
}

-(BCUser*)getAssignee{
    return _issue.assignee;
}


@end
