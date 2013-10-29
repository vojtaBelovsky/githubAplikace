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

#define ANIMATION_DURATION ( 0.2f )

@interface BCIssueDetailViewController ()

@end

#pragma mark -
#pragma mark lifecycles

@implementation BCIssueDetailViewController

- (id)initWithIssue:(BCIssue *)issue andController:(BCIssueViewController *)controller
{
  self = [super init];
  if (self) {
    _myParentViewController = controller;
    _issue = issue;
    _editedIssue = [issue copy];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
  }
  return self;
}

-(void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) loadView{
  _issueDetailView = [[BCIssueDetailView alloc] initWithIssue:_issue andController:self];

  [_issueDetailView.backButton addTarget:self action:@selector(backButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_issueDetailView.closeButton addTarget:self action:@selector(closeButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_issueDetailView.addNewCommentButton addTarget:self action:@selector(addNewCommentButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
  self.view = _issueDetailView;
  [self.view addGestureRecognizer:tapRecognizer];
  
  [_issueDetailView.activityIndicatorView startAnimating];
  [_issueDetailView setUserInteractionEnabled:NO];
  [BCComment getCommentsForIssue:_issue withSuccess:^(NSMutableArray *comments) {
    [_issueDetailView setCommentViewsWithComments:comments];
    [_issueDetailView.activityIndicatorView stopAnimating];
    [_issueDetailView setUserInteractionEnabled:YES];
  } failure:^(NSError *error) {
    [UIAlertView showWithError:error];
    [_issueDetailView.activityIndicatorView stopAnimating];
    [_issueDetailView setUserInteractionEnabled:YES];
  }];
}

-(void) viewWillAppear:(BOOL)animated{
    [_issueDetailView.issueView setIssue:_editedIssue];
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
  [commentView.commentTextView becomeFirstResponder];
  _issueDetailView.myNewCommentView = commentView;
  [_issueDetailView addSubview:_issueDetailView.myNewCommentView];
  _issueDetailView.myNewCommentView.alpha = 0.0f;
  
  [UIView animateWithDuration:ANIMATION_DURATION animations:^{
    _issueDetailView.myNewCommentView.alpha = 1.0f;
  }];
  
  _issueDetailView.addedNewComment = YES;
  _heightOfNewComment = [commentView sizeOfViewWithWidth:ISSUE_WIDTH].height;
}

-(void)commentButtonDidPress{
  NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues/%@/comments", _issue.repository.owner.userLogin, _issue.repository.name, _issue.number];
  NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:_issueDetailView.myNewCommentView.commentTextView.text, @"body", nil];
  [_issueDetailView.activityIndicatorView startAnimating];
  [_issueDetailView bringSubviewToFront:_issueDetailView.activityIndicatorView];
  [_issueDetailView setUserInteractionEnabled:NO];
  [[BCHTTPClient sharedInstance] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [_issueDetailView.myNewCommentView setDisabledForCommenting];
    _issueDetailView.myNewCommentView = nil;
    [_issueDetailView setNeedsLayout];
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      [_issueDetailView.addNewCommentButton setHidden:NO];
      [_issueDetailView.activityIndicatorView stopAnimating];
      [_issueDetailView setUserInteractionEnabled:YES];
    }];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [UIAlertView showWithError:error];
    [_issueDetailView.activityIndicatorView stopAnimating];
    [_issueDetailView setUserInteractionEnabled:YES];
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
//    [_issueDetailview.issueView setIssue:_issue];
//}

#pragma mark -
#pragma mark private

-(void)hideKeyboard{
  [_issueDetailView.myNewCommentView.commentTextView resignFirstResponder];
}

- (void) keyboardDidHide:(NSNotification *)notification{
//  CGPoint bottomOffset = CGPointMake(0, _issueDetailView.contentSize.height-_issueDetailView.frame.size.height);
//  if (bottomOffset.y > 0) {
//    [_issueDetailView setContentOffset:bottomOffset animated:YES];
//  }
}

-(void)keyboardWillHide:(NSNotification *) notification{
  NSDictionary* info = [notification userInfo];
  NSNumber *number = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  double duration = [number doubleValue];
  CGPoint bottomOffset = CGPointMake(0, _issueDetailView.contentSize.height-_issueDetailView.sizeOfKeyborad-_issueDetailView.frame.size.height);
  if (bottomOffset.y > 0) {
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      [_issueDetailView setContentOffset:bottomOffset animated:NO];
    } completion:nil];
  }
  _issueDetailView.sizeOfKeyborad = 0;
}

-(void)keyboardWillShow:(NSNotification *) notification{
  NSDictionary* info = [notification userInfo];
  NSValue* keyboardFrameBegin = [info valueForKey:UIKeyboardFrameBeginUserInfoKey];
  CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
  _issueDetailView.sizeOfKeyborad = keyboardFrameBeginRect.size.height;
  NSNumber *number = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  double duration = [number doubleValue];
  
  CGPoint bottomOffset = CGPointMake(0, _issueDetailView.contentSize.height+_issueDetailView.sizeOfKeyborad+_heightOfNewComment+BOTTOM_OFFSET-_issueDetailView.frame.size.height);
  if (bottomOffset.y > 0) {
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      [_issueDetailView setContentOffset:bottomOffset animated:NO];
    } completion:nil];
  }
}

- (void) keyboardDidShow:(NSNotification *)notification{

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
