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
        _editedIssue = [issue copy]; //ZKUSIT JETLI POTREBUJU HLUBOKOU KOPII!!!
        _cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonAction)];
        _editButton = [self editButtonItem];
        [_buttons setValue:_editButton forKey:@"editButton"];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [[BCIssueDetailView alloc] initWithIssue:_issue];
    //view delegate?
    
    
	// Do any additional setup after loading the view.
}



#pragma mark -
#pragma mark ButtonActions

-(void) cancelButtonAction{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
