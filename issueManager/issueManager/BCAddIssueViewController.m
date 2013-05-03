//
//  BCAddIssueViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/30/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCAddIssueViewController.h"
#import "BCSelectAssigneeViewController.h"
#import "BCRepository.h"
#import "BCAddIssueView.h"
#import "BCUser.h"
#import "UIAlertView+errorAlert.h"
#import "BCHTTPClient.h"

@interface BCAddIssueViewController ()

@end

@implementation BCAddIssueViewController

- (id)initWithRepository:(BCRepository *)repository
{
    self = [super init];
    if (self) {
        _assignee = NULL;
        _repository = repository;
        _isSetedAssignee = NO;
    }
    return self;
}

-(void) loadView{
    [super loadView];
    _issueDetailview = [[BCAddIssueView alloc] initWithController:self];
    [_issueDetailview.title setDelegate:self];
    [_issueDetailview.body setDelegate:self];
    self.view = _issueDetailview;
    [self setItemsEditable:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStylePlain target:self action:@selector(addNewIssueButtonAction)];
}

-(void) viewWillAppear:(BOOL)animated{
    [_issueDetailview rewriteContentWithAssignee:_assignee];
}

#pragma mark -
#pragma mark ButtonActions

-(void) selectAssignee{
    [self createAndPushSelectAssigneVC];
}

-(void)addNewIssueButtonAction{
    NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues", _repository.owner.userLogin, _repository.name];
    [[BCHTTPClient sharedInstance] postPath:path parameters:[self createParameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Issue was created");
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIAlertView showWithError:error];
    }];
}

#pragma mark -
#pragma mark delegateMethods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self createAndPushSelectAssigneVC];
    return YES;
}


#pragma mark -
#pragma mark private

-(void)createAndPushSelectAssigneVC{
    BCSelectAssigneeViewController *selectAssigneeVC = [[BCSelectAssigneeViewController alloc] initWithRepository:_repository andController:self];
    [self.navigationController pushViewController:selectAssigneeVC animated:YES];
}

-(void)setItemsEditable:(BOOL)isEditable{
    [_issueDetailview.body setEditable:isEditable];
    [_issueDetailview.title setEnabled:isEditable];
    [_issueDetailview.assignee setEnabled:isEditable];
}

-(NSDictionary *) createParameters{
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _issueDetailview.title.text ?: [NSNull null], @"title",
                                _issueDetailview.body.text ?: [NSNull null], @"body",
                                _assignee.userLogin ?: [NSNull null], @"assignee",
                                nil];
    return parameters;
}

#pragma mark -
#pragma mark public

-(void) setNewAssignee:(BCUser *)assignee{
    if(assignee != NULL){
        [self setIsSetedAssignee:YES];
    }
    _assignee = assignee;
}

-(BCUser*)getAssignee{
    return _assignee;
}

@end
