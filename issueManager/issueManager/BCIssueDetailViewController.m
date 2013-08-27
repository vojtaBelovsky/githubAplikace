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
#import "BCCommentView.h"
#import "BCComment.h"

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
  }
  return self;
}

-(void) loadView{
  _issueDetailview = [[BCIssueDetailView alloc] initWithIssue:_issue andController:self];
  [_issueDetailview.backButton addTarget:self action:@selector(backButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_issueDetailview.closeButton addTarget:self action:@selector(closeButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_issueDetailview.addNewCommentButton addTarget:self action:@selector(addNewCommentButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  self.view = _issueDetailview;
}

-(void) viewWillAppear:(BOOL)animated{
    [_issueDetailview.issueView setWithIssue:_editedIssue];
}

#pragma mark -
#pragma mark ButtonActions

-(void)backButtonDidPress{
  [_myParentViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)closeButtonDidPress{
  NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues/%d",   _issue.repository.owner.userLogin, _issue.repository.name, [_issue.number intValue]];
  [[BCHTTPClient sharedInstance] patchPath:path parameters:[self createParameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [_myParentViewController removeIssue:_issue];
    [_myParentViewController dismissViewControllerAnimated:YES completion:nil];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [UIAlertView showWithError:error];
  }];
}

-(void)addNewCommentButtonDidPress{
  BCCommentView *commentView = [[BCCommentView alloc] initWithComment:[[BCComment alloc] initNewComment]];
  [commentView setEnabledForCommenting];
  [commentView.commentButton addTarget:self action:@selector(commentButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  _issueDetailview.myNewCommentView = commentView;
  [_issueDetailview addSubview:_issueDetailview.myNewCommentView];
  _issueDetailview.myNewCommentView.alpha = 0.0f;
  
  [UIView animateWithDuration:0.2f animations:^{
    _issueDetailview.myNewCommentView.alpha = 1.0f;
  }];
  
  _issueDetailview.addedNewComment = YES;
}

-(void)commentButtonDidPress{
  NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues/%@/comments", _issue.repository.owner.userLogin, _issue.repository.name, _issue.number];
  NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:_issueDetailview.myNewCommentView.commentTextView.text, @"body", nil];
  [[BCHTTPClient sharedInstance] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [_issueDetailview.myNewCommentView setDisabledForCommenting];
    _issueDetailview.myNewCommentView = nil;
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [UIAlertView showWithError:error];
  }];
}

//-(void) editButtionAction{
//    if([self isEditing]){
////        [_editedIssue setTitle:_issueDetailview.title.text];
////        [_editedIssue setBody:_issueDetailview.body.text];
//        NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues/%d", _issue.repository.owner.userLogin, _issue.repository.name, [_issue.number intValue]];
//        [[BCHTTPClient sharedInstance] patchPath:path parameters:[self createParameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"Issue was updated");
//            [_myParentViewController changeIssue:_issue forNewIssue:_editedIssue];
//            [self.navigationController popViewControllerAnimated:YES];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            if([[_editedIssue title] isEqualToString:@""]){
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty title" message:@"Title can't be empty" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//                [alert show];
//            }else{
//                [UIAlertView showWithError:error];
//            }
//        }];
//        
//    }else{
//        [self setEditing:YES];
//        [self setItemsEditable:YES];
//        [_buttons addObject:_cancelButton];
//        self.navigationItem.rightBarButtonItems = _buttons;
////        [_issueDetailview.title becomeFirstResponder];
//    }
//}
//
//-(void) cancelButtonAction{
//    [self setItemsEditable:NO];
//    [self setEditing:NO];
//    [_buttons removeObject:_cancelButton];
//    _editedIssue = [_issue copy];
//    self.navigationItem.rightBarButtonItems = _buttons;
//    
//    [_issueDetailview.issueView setWithIssue:_issue];
//}

#pragma mark -
#pragma mark private

- (void) keyboardDidHide:(NSNotification*)notification{//zmensi velikost skrolovatelneho obsahu
  _issueDetailview.sizeOfKeyborad = 0;
}

- (void) keyboardDidShow:(NSNotification*)notification{//zvetsi velikost skrolovatelneho obsahu
  NSDictionary* keyboardInfo = [notification userInfo];
  NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
  CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
  _issueDetailview.sizeOfKeyborad = keyboardFrameBeginRect.size.height;
}

-(NSDictionary *) createParameters{
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _editedIssue.title ?: [NSNull null], @"title",
                                _editedIssue.body ?: [NSNull null], @"body",
                                _editedIssue.assignee.userLogin ?: [NSNull null], @"assignee",
                                @"closed", @"state",
                                _editedIssue.milestone.number ?: [NSNull null], @"milestone",
                                ([_editedIssue getLabelsAsStrings]) ?: [NSNull null], @"labels",
                                nil];
    return parameters;
}

@end
