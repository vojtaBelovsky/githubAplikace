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
    NSArray *_repositories;
  BCRepositoryViewController *_repoViewController;
}

- (id)initWithRepositories:(NSArray *)repositories andNavigationController:(BCRepositoryViewController *)repoViewController;

-(BCRepository *)getRepositoryAtIndex:(NSUInteger)row;
-(NSInteger)getNumberOfRowsToAddToSection:(NSUInteger)section;

@property (strong) NSMutableArray *actualSelected;
@end
