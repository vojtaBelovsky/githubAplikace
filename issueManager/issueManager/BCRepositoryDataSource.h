//
//  BCRepositoryDataSource.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BCRepository;
@class BCRepositoryViewController;

@interface BCRepositoryDataSource : NSObject<UITableViewDataSource>{
@private
  NSDictionary *_repositories;
  NSArray *_keyNames;
  BCRepositoryViewController *_repoViewController;
}

- (id)initWithRepositories:(NSDictionary *)repositories repositoryNames:(NSArray *) repoNames andNavigationController:(BCRepositoryViewController *)repoViewController;

-(BCRepository *)getRepositoryAtIndex:(NSIndexPath *)indexPath;
-(NSInteger)getNumberOfRowsToAddToSection:(NSUInteger)section;

@property (strong) NSMutableArray *actualSelected;
@end
