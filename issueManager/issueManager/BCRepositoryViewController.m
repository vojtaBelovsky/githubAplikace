//
//  BCRepositoryViewController.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 4/19/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCRepositoryViewController.h"
#import "BCRepositoryView.h"

@interface BCRepositoryViewController ()
- (void)createModel;
@end

@implementation BCRepositoryViewController

#pragma mark -
#pragma mark LifeCycles

- (id)init {
    self = [super init];
    if ( self ) {
        
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
    
    _repoView = [[BCRepositoryView alloc] init];
    self.view = _repoView;
}

#pragma mark -
#pragma mark Private


@end
