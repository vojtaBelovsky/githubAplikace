//
//  BCIssueViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueViewController.h"
#import "BCRepository.h"

@interface BCIssueViewController ()

@end

@implementation BCIssueViewController

- (id) initWithRepository:(BCRepository *)repository{
    self = [super init];
    if(self){
        _repository = repository;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonAction)];
    }
    return self;
}

- (void)addButtonAction{
    NSLog(@"do action");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
