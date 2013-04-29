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

@interface BCIssueDetailViewController ()

@end

@implementation BCIssueDetailViewController

- (id)initWithIssue:(BCIssue *)issue
{
    self = [super init];
    if (self) {
        _issue = issue;
        _editedIssue = issue;
        //_editedIssue = [issue copy]; //ZKUSIT JETLI POTREBUJU HLUBOKOU KOPII!!!
        _cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonAction)];
        _editButton = [self editButtonItem];
        [_editButton setTarget:self];
        [_editButton setAction:@selector(editButtionAction)];
        _buttons = [[NSArray alloc] initWithObjects:_editButton, nil];
        
        
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
        
    }
}

#pragma mark -
#pragma mark ButtonActions

-(void) selectAssignee{
    NSLog(@"select assignee");//PUSH SELECT ASSIGNEE VIEW CONTROLLER
}

-(void) editButtionAction{
    if([self isEditing]){
        [self setEditing:NO];
        //poslat zmeny na server
    }else{
        [self setEditing:YES];
        [self setItemsEditable:YES];
        [_issueDetailview.title becomeFirstResponder];
    }
}

-(void) cancelButtonAction{
    [self setItemsEditable:NO];
    [_issueDetailview rewriteContentWithIssue:_issue];
}

#pragma mark -
#pragma mark delegateMethods

- (void)textViewDidEndEditing:(UITextView *)textView{
    [_editedIssue setTitle:textView.text];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_editedIssue setBody:textField.text];
    return YES;
}

#pragma mark -
#pragma mark private

-(void)createAndPushSelectAssigneVC{
    
}

-(void)setItemsEditable:(BOOL)isEditable{
    [_issueDetailview.title setEditable:isEditable];
    [_issueDetailview.body setEnabled:isEditable];
    [_issueDetailview.assignee setEnabled:isEditable];
}

@end
