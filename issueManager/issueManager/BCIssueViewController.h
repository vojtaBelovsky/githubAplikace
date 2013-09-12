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

@interface BCIssueViewController : UIViewController <UITableViewDelegate, UIScrollViewDelegate>{
@private
  NSArray *_repositories;
  BCIssueView *_tableView;
  int _nthRepository;
  NSMutableArray *_allDataSources;
}
@property   UITapGestureRecognizer *slideBack;
@property TMViewDeckController *deckController;
@property BOOL userChanged;

- (id) initWithRepositories:(NSArray *)repositories;

-(void)addNewIssue:(BCIssue *)newIssue;
-(void)changeIssue:(BCIssue *)issue forNewIssue:(BCIssue*)newIssue;
-(void)removeIssue:(BCIssue *)issue;
-(void)slideBackCenterView;

@end
