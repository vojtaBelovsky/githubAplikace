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
#import "BCLabel.h"
#import "BCSelectMilestoneViewController.h"
#import "BCSelectLabelsViewController.h"
#import "BCIssueViewController.h"
#import "BCSingleIssueView.h"

@interface BCIssueDetailViewController ()

@end

@implementation BCIssueDetailViewController

- (id)initWithIssue:(BCIssue *)issue andController:(BCIssueViewController *)controller
{
  self = [super init];
  if (self) {
    _myParentViewController = controller;
    _issue = issue;
    _editedIssue = [issue copy];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    if(_issue.assignee == nil){
      _isSetedAssignee = NO;
    }else{
      _isSetedAssignee = YES;
    }
    if(_issue.milestone == nil){
      _isSetedMilestone = NO;
    }else{
      _isSetedMilestone = YES;
    }
    if(_issue.labels == nil){
      _isSetedLabel = NO;
    }else{
      _isSetedLabel = YES;
    }
  }
  return self;
}

-(void) loadView{
  _issueDetailview = [[BCIssueDetailView alloc] initWithIssue:_issue andController:self];
  [_issueDetailview.backButton addTarget:self action:@selector(backButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  self.view = _issueDetailview;
  self.navigationItem.rightBarButtonItems = _buttons;
}

-(void) viewWillAppear:(BOOL)animated{
    [_issueDetailview.issueView setWithIssue:_editedIssue];
}

#pragma mark -
#pragma mark ButtonActions

-(void) selectLabel{
    [self createAndPushSelectMilestoneVC];
}

-(void) selectAssignee{
    [self createAndPushSelectAssigneVC];
}

-(void) selectLabels{
    [self createAndPushSelectLabelsVC];
}

-(void) editButtionAction{
    if([self isEditing]){
//        [_editedIssue setTitle:_issueDetailview.title.text];
//        [_editedIssue setBody:_issueDetailview.body.text];
        NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues/%d", _issue.repository.owner.userLogin, _issue.repository.name, [_issue.number intValue]];
        [[BCHTTPClient sharedInstance] patchPath:path parameters:[self createParameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Issue was updated");
            [_myParentViewController changeIssue:_issue forNewIssue:_editedIssue];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if([[_editedIssue title] isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty title" message:@"Title can't be empty" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [alert show];
            }else{
                [UIAlertView showWithError:error];
            }
        }];
        
    }else{
        [self setEditing:YES];
        [self setItemsEditable:YES];
        [_buttons addObject:_cancelButton];
        self.navigationItem.rightBarButtonItems = _buttons;
//        [_issueDetailview.title becomeFirstResponder];
    }
}

-(void) cancelButtonAction{
    [self setItemsEditable:NO];
    [self setEditing:NO];
    [_buttons removeObject:_cancelButton];
    _editedIssue = [_issue copy];
    self.navigationItem.rightBarButtonItems = _buttons;
    
    [_issueDetailview.issueView setWithIssue:_issue];
}

#pragma mark - buttonActions

-(void)backButtonDidPress{
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark delegateMethods

- (void)textViewDidEndEditing:(UITextView *)textView{
//    [_editedIssue setBody:_issueDetailview.body.text];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
//    [_editedIssue setTitle:_issueDetailview.title.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self createAndPushSelectAssigneVC];
    return YES;
}

#pragma mark -
#pragma mark private

- (void) keyboardDidHide:(NSNotification*)notification{//zmensi velikost skrolovatelneho obsahu
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGSize scrollContentSize = CGSizeMake(CGRectGetWidth(_issueDetailview.frame), CGRectGetHeight(_issueDetailview.frame)-keyboardFrameBeginRect.size.height);
    _issueDetailview.contentSize = scrollContentSize;
}

- (void) keyboardDidShow:(NSNotification*)notification{//zvetsi velikost skrolovatelneho obsahu
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGSize scrollContentSize = CGSizeMake(CGRectGetWidth(_issueDetailview.frame), CGRectGetHeight(_issueDetailview.frame)+keyboardFrameBeginRect.size.height);
    _issueDetailview.contentSize = scrollContentSize;
}

-(void)createAndPushSelectAssigneVC{
    BCSelectAssigneeViewController *selectAssigneeVC = [[BCSelectAssigneeViewController alloc] initWithRepository:_issue.repository andController:self];
    [self.navigationController pushViewController:selectAssigneeVC animated:YES];
}

-(void)createAndPushSelectMilestoneVC{
    BCSelectMilestoneViewController *selectMilestoneVC = [[BCSelectMilestoneViewController alloc] initWithRepository:_issue.repository andController:self];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:selectMilestoneVC animated:YES];
}

-(void)createAndPushSelectLabelsVC{
    BCSelectLabelsViewController *selectLabelsVC = [[BCSelectLabelsViewController alloc] initWithRepository:_issue.repository andController:self];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:selectLabelsVC animated:YES];
}

-(void)setItemsEditable:(BOOL)isEditable{
//    [_issueDetailview.body setEditable:isEditable];
//    [_issueDetailview.title setEnabled:isEditable];
//    [_issueDetailview.assignee setEnabled:isEditable];
//    [_issueDetailview.milestone setEnabled:isEditable];
//    [_issueDetailview.labelsButton setEnabled:isEditable];
}

-(NSDictionary *) createParameters{
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _editedIssue.title ?: [NSNull null], @"title",
                                _editedIssue.body ?: [NSNull null], @"body",
                                _editedIssue.assignee.userLogin ?: [NSNull null], @"assignee",
                                (_editedIssue.state == GHIssueStateOpen) ? @"open" : @"closed", @"state",
                                _editedIssue.milestone.number ?: [NSNull null], @"milestone",
                                ([_editedIssue getLabelsAsStrings]) ?: [NSNull null], @"labels",
                                nil];
    return parameters;
}

#pragma mark -
#pragma mark public

-(void) setNewAssignee:(BCUser *)assignee{
    if(assignee != NULL){
        [self setIsSetedAssignee:YES];
    }
    [_editedIssue setAssignee:assignee];
}

-(BCUser*)getAssignee{
    return _editedIssue.assignee;
}

-(void)setNewMilestone:(BCMilestone *)milestone{
    if(milestone != NULL){
        [self setIsSetedMilestone:YES];
    }else{
        [self setIsSetedMilestone:NO];
    }
    [_editedIssue setMilestone:milestone];
}

-(BCMilestone *)getMilestone{
    return [_editedIssue milestone];
}

-(void)setNewLables:(NSArray *)labels{
    if(labels != NULL){
        [self setIsSetedLabel:YES];
    }else{
        [self setIsSetedLabel:NO];
    }
    [_editedIssue setLabels:labels];
}

-(NSArray *)getLabels{
    return [_editedIssue labels];
}

@end
