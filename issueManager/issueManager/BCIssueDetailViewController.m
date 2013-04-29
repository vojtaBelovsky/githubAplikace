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
    _issueDetailview = [[BCIssueDetailView alloc] initWithIssue:_issue];
    self.view = _issueDetailview;
    self.navigationItem.rightBarButtonItems = _buttons;
}

-(void) viewWillAppear:(BOOL)animated{
    if([self isEditing]){
        
    }
}

#pragma mark -
#pragma mark ButtonActions

-(void) editButtionAction{
    [self setEditing:YES];
    [_issueDetailview.title setEditable:YES];
    [_issueDetailview.body setEnabled:YES];
    
}

-(void) cancelButtonAction{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
