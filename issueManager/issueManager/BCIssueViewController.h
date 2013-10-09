//
//  BCIssueViewController.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCRepository;
@class BCIssue;
@class BCIssueView;
@class BCIssueDataSource;
@class TMViewDeckController;
@class BCUser;

@interface BCIssueViewController : UIViewController <UITableViewDelegate, UIScrollViewDelegate>{
@private
  int _nthRepository;
  NSMutableArray *_allDataSources;
  NSMutableArray *_allCollaborators;
  BOOL _isShownRepoVC;
}

@property BCIssueView *issueView;
@property BOOL isChangedRepositories;
@property NSArray *repositories;
@property UITapGestureRecognizer *slideBack;
@property BOOL userChanged;
@property BCUser *currentUser;

- (id) initWithRepositories:(NSArray *)repositories andLoggedInUser:(BCUser *)user;

-(void)addNewIssue:(BCIssue *)newIssue;
-(void)changeIssue:(BCIssue *)issue forNewIssue:(BCIssue*)newIssue;
-(void)removeIssue:(BCIssue *)issue;
-(void)slideBackCenterView;
-(void)setRepositoriesAndReloadDataWithRepositories:(NSArray*)repositories;

@end
