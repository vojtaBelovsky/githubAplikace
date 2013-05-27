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

@interface BCAddIssueViewController ()

@end

@implementation BCAddIssueViewController

- (id)initWithRepository:(BCRepository *)repository
{
    self = [super init];
    if (self) {
        _assignee = [[BCUser alloc] init];
        _milestone = [[BCMilestone alloc] init];
        _labels = [[NSArray alloc] init];
        _repository = repository;
        _isSetedAssignee = NO;
        _isSetedMilestone = NO;
        _isSetedLabel = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}

-(void) loadView{
    [super loadView];
    _addIssueView = [[BCAddIssueView alloc] initWithController:self];
    [_addIssueView.title setDelegate:self];
    [_addIssueView.body setDelegate:self];
    self.view = _addIssueView;
    [self setItemsEditable:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStylePlain target:self action:@selector(addNewIssueButtonAction)];
}

-(void) viewWillAppear:(BOOL)animated{
    [_addIssueView rewriteContentWithAssignee:_assignee milestone:_milestone andLabels:_labels];
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

-(void)setItemsEditable:(BOOL)isEditable{
    [_addIssueView.body setEditable:isEditable];
    [_addIssueView.title setEnabled:isEditable];
    [_addIssueView.assignee setEnabled:isEditable];
    [_addIssueView.milestone setEnabled:isEditable];
    [_addIssueView.labelsButton setEnabled:isEditable];
}

-(NSDictionary *)createParameters{
    NSMutableArray *labelsNames = [[NSMutableArray alloc] init];
    for(BCLabel *object in _labels){
        [labelsNames addObject:object.name];
    }
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _addIssueView.title.text ?: [NSNull null], @"title",
                                _addIssueView.body.text ?: [NSNull null], @"body",
                                _assignee.userLogin ?: [NSNull null], @"assignee",
                                _milestone.number ?: [NSNull null], @"milestone",
                                labelsNames ?: [NSNull null], @"labels",
                                nil];
    return parameters;
}

#pragma mark -
#pragma mark public

-(void)setNewAssignee:(BCUser *)assignee{
    if(assignee.userId != 0){
        [self setIsSetedAssignee:YES];
    }else{
        [self setIsSetedAssignee:NO];
    }
    _assignee = assignee;
}

-(BCUser *)getAssignee{
    return _assignee;
}

-(void)setNewMilestone:(BCMilestone *)milestone{
    if(milestone.number != 0){
        [self setIsSetedMilestone:YES];
    }else{
        [self setIsSetedMilestone:NO];
    }
    _milestone = milestone;
}

-(BCMilestone *)getMilestone{
    return _milestone;
}

-(void)setNewLables:(NSArray *)labels{
    if([labels count] != 0){
        [self setIsSetedLabel:YES];
    }else{
        [self setIsSetedLabel:NO];
    }
    _labels = labels;
}

-(NSArray *)getLabels{
    return _labels;
}



@end
