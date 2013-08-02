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
#import "BCSelectMilestoneViewController.h"
#import "BCSelectLabelsViewController.h"
#import "BCMilestone.h"
#import "BCLabel.h"
#import "BCIssueViewController.h"
#import "BCIssue.h"
#import "BCAddIssueTextField.h"
#import "BCaddIssueButton.h"
#import "BCAddIssueButtonMC.h"

#define BODY_FONT_COLOR                 [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00]

#define BODY_FONT              [UIFont fontWithName:@"ProximaNova-Regular" size:16]

#define VIEW_OFFSET           ( -200.0f )
#define ANIMATION_DURATION    ( 0.2f )

@interface BCAddIssueViewController ()

@end

@implementation BCAddIssueViewController

- (id)initWithRepository:(BCRepository *)repository andController:(BCIssueViewController *)controller{
  self = [super init];
  if (self) {
    BCUser *currentUser = [BCUser sharedInstanceChangeableWithUser:nil succes:nil failure:nil];
    _assignee = currentUser;
    _milestone = nil;
    _labels = [[NSArray alloc] init];
    _repository = repository;
    _myParentViewController = controller;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
  }
  return self;
}

-(void)dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

-(void) loadView{
  _addIssueView = [[BCAddIssueView alloc] initWithController:self];
  [_addIssueView.issueTitle.textField setDelegate:self];
  self.view = _addIssueView;
  
  UITapGestureRecognizer *addMilestoneTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createAndPushSelectMilestoneVC)];
  [_addIssueView.addMilestone addGestureRecognizer:addMilestoneTapRecognizer];
  
  UITapGestureRecognizer *selectAssigneeTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createAndPushSelectAssigneVC)];
  [_addIssueView. selectAssignee addGestureRecognizer:selectAssigneeTapRecognizer];
  
  UITapGestureRecognizer *selectLabelsTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createAndPushSelectLabelsVC)];
  [_addIssueView.selectLabels addGestureRecognizer:selectLabelsTapRecognizer];
  
  [_addIssueView.cancelButton addTarget:self action:@selector(cancelButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_addIssueView.postButton addTarget:self action:@selector(postButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  
  [_addIssueView.issueBody setDelegate:self];
}

-(void) viewWillAppear:(BOOL)animated{
    [_addIssueView rewriteContentWithAssignee:_assignee milestone:_milestone andLabels:_labels];
}

#pragma mark -
#pragma mark ButtonActions

-(void) cancelButtonDidPress{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void)postButtonDidPress{
  NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues", _repository.owner.userLogin, _repository.name];
  NSMutableDictionary *params = [self createParameters];
  if ([params objectForKey:@"title"] == [NSNull null]) {
    [UIAlertView showWithError:[[NSError alloc] initWithDomain:@"EMPTY TITLE" code:13 userInfo:nil]];
    return;
  }else{
    if ([(NSString*)[params objectForKey:@"title" ] length] == 0) {
      [UIAlertView showWithError:[[NSError alloc] initWithDomain:@"EMPTY TITLE" code:13 userInfo:nil]];
      return;
    }
  }
  
  if ([(NSString*)[params objectForKey:@"body"] isEqualToString:@"What is the problem?"]) {
    [params setObject:@"" forKey:@"body"];
  }
  [[BCHTTPClient sharedInstance] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    BCIssue *newIssue = [MTLJSONAdapter modelOfClass:[BCIssue class] fromJSONDictionary:responseObject error:nil];
    [_myParentViewController addNewIssue:newIssue];
    [self.navigationController popViewControllerAnimated:YES];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [UIAlertView showWithError:error];
  }];
}


#pragma mark -
#pragma mark private

- (void) keyboardDidHide:(NSNotification*)notification{//zmensi velikost skrolovatelneho obsahu
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGSize scrollContentSize = CGSizeMake(CGRectGetWidth(_addIssueView.frame), CGRectGetHeight(_addIssueView.frame)-keyboardFrameBeginRect.size.height);
    _addIssueView.contentSize = scrollContentSize;
}

- (void) keyboardDidShow:(NSNotification*)notification{//zvetsi velikost skrolovatelneho obsahu
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGSize scrollContentSize = CGSizeMake(CGRectGetWidth(_addIssueView.frame), CGRectGetHeight(_addIssueView.frame)+keyboardFrameBeginRect.size.height);
    _addIssueView.contentSize = scrollContentSize;
}

-(void)createAndPushSelectAssigneVC{
    BCSelectAssigneeViewController *selectAssigneeVC = [[BCSelectAssigneeViewController alloc] initWithRepository:_repository andController:self];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:selectAssigneeVC animated:YES];
}

-(void)createAndPushSelectMilestoneVC{
    BCSelectMilestoneViewController *selectMilestoneVC = [[BCSelectMilestoneViewController alloc] initWithRepository:_repository andController:self];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:selectMilestoneVC animated:YES];
}

-(void)createAndPushSelectLabelsVC{
    BCSelectLabelsViewController *selectLabelsVC = [[BCSelectLabelsViewController alloc] initWithRepository:_repository andController:self];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:selectLabelsVC animated:YES];
}

-(NSMutableDictionary *)createParameters{
  NSMutableArray *labelsNames = [[NSMutableArray alloc] init];
  for(BCLabel *object in _labels){
    [labelsNames addObject:object.name];
  }
  NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                _addIssueView.issueTitle.textField.text ?: [NSNull null], @"title",
                                _addIssueView.issueBody.text ?: [NSNull null], @"body",
                                _assignee.userLogin ?: [NSNull null], @"assignee",
                                _milestone.number ?: [NSNull null], @"milestone",
                                labelsNames ?: [NSNull null], @"labels",
                                nil];
  return parameters;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - placeholder carrying

-(void)textViewDidBeginEditing:(UITextView *)textView{
  if ([textView.text isEqualToString:@"What is the problem?"]) {
    textView.text = @"";
    textView.font = BODY_FONT;
    textView.textColor = BODY_FONT_COLOR;
  }
}

#pragma mark -
#pragma mark BCSelectDataManagerProtocolMethods

-(void)setNewAssignee:(BCUser *)assignee{
    _assignee = assignee;
}

-(BCUser *)getAssignee{
    return _assignee;
}

-(void)setNewMilestone:(BCMilestone *)milestone{
    _milestone = milestone;
}

-(BCMilestone *)getMilestone{
    return _milestone;
}

-(void)setNewLables:(NSArray *)labels{
    _labels = labels;
}

-(NSArray *)getLabels{
    return _labels;
}



@end
