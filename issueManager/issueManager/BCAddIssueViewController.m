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

@interface BCAddIssueViewController ()

@end

@implementation BCAddIssueViewController

- (id)initWithRepository:(BCRepository *)repository withController:(BCIssueViewController *)controller withCurrentUser:(BCUser*)user{
  self = [super init];
  if (self) {
    BCUser *currentUser = user;
    _checkedAssignee = currentUser;
    _checkedMilestone = nil;
    _checkedLabels = [[NSMutableArray alloc] init];
    _repository = repository;
    _myParentViewController = controller;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [self getData];
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
  [_addIssueView.createButton addTarget:self action:@selector(createButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_addIssueView.issueBody setDelegate:self];
}

-(void) viewWillAppear:(BOOL)animated{
    [_addIssueView rewriteContentWithAssignee:_checkedAssignee milestone:_checkedMilestone andLabels:_checkedLabels];
}

#pragma mark -
#pragma mark ButtonActions

-(void) cancelButtonDidPress{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void)createButtonDidPress{
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
  
  NSString *path = [[NSString alloc] initWithFormat:@"/repos/%@/%@/issues", _repository.owner.userLogin, _repository.name];  
  if ([(NSString*)[params objectForKey:@"body"] isEqualToString:@"What is the problem?"]) {
    [params setObject:@"" forKey:@"body"];
  }
  [[BCHTTPClient sharedInstance] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    BCIssue *newIssue = [MTLJSONAdapter modelOfClass:[BCIssue class] fromJSONDictionary:responseObject error:nil];
    [newIssue setRepository:_repository];
    [_myParentViewController addNewIssue:newIssue];
    [self.navigationController popViewControllerAnimated:YES];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [UIAlertView showWithError:error];
  }];
}


#pragma mark -
#pragma mark private

-(void)getData{
  [self getLabels];
  [self getMilestones];
  [self getCollaborators];
}

-(void)getLabels{
  [BCRepository getAllLabelsOfRepository:_repository withSuccess:^(NSArray *allLabels) {
    _labels = allLabels;
  } failure:^(NSError *error) {
    NSLog(@"fail");
  }];
}

-(void)getMilestones{
  [BCRepository getAllMilestonesOfRepository:_repository withSuccess:^(NSArray *allMilestones) {
    _milestones = allMilestones;
  } failure:^(NSError *error) {
    NSLog(@"fail");
  }];
}

-(void)getCollaborators{
  [BCRepository getAllCollaboratorsOfRepository:_repository withSuccess:^(NSArray *allCollaborators) {
    _collaborators = allCollaborators;
  } failure:^(NSError *error) {
    NSLog(@"fail");
  }];
}

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
  BCSelectAssigneeViewController *selectAssigneeVC = [[BCSelectAssigneeViewController alloc] initWithController:self];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:selectAssigneeVC animated:YES];
}

-(void)createAndPushSelectMilestoneVC{
  BCSelectMilestoneViewController *selectMilestoneVC = [[BCSelectMilestoneViewController alloc] initWithController:self];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:selectMilestoneVC animated:YES];
}

-(void)createAndPushSelectLabelsVC{
  BCSelectLabelsViewController *selectLabelsVC = [[BCSelectLabelsViewController alloc] initWithController:self];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:selectLabelsVC animated:YES];
}

-(NSMutableDictionary *)createParameters{
  NSMutableArray *labelsNames = [[NSMutableArray alloc] init];
  for(BCLabel *object in _checkedLabels){
    [labelsNames addObject:object.name];
  }
  NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                _addIssueView.issueTitle.textField.text ?: [NSNull null], @"title",
                                _addIssueView.issueBody.text ?: [NSNull null], @"body",
                                _checkedAssignee.userLogin ?: [NSNull null], @"assignee",
                                _checkedMilestone.number ?: [NSNull null], @"milestone",
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

@end
