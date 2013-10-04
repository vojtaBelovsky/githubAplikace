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

@interface BCIssueViewController : UITableViewController <UITableViewDelegate, UIScrollViewDelegate>{
@private
  NSArray *_repositories;
  BCIssueView *_tableView;
  int _nthRepository;
  NSMutableArray *_allDataSources;
  NSMutableArray *_allCollaborators;
  BOOL _isShownRepoVC;
}

@property UITapGestureRecognizer *slideBack;
@property TMViewDeckController *deckController;
@property BOOL userChanged;
@property BCUser *currentUser;

- (id) initWithRepositories:(NSArray *)repositories;

-(void)addNewIssue:(BCIssue *)newIssue;
-(void)changeIssue:(BCIssue *)issue forNewIssue:(BCIssue*)newIssue;
-(void)removeIssue:(BCIssue *)issue;
-(void)slideBackCenterView;

@end
