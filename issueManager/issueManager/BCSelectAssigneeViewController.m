//
//  BCSelectAssigneeViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeViewController.h"
#import "BCRepository.h"

@interface BCSelectAssigneeViewController ()

@end

@implementation BCSelectAssigneeViewController

- (id)initWithRepository:(BCRepository *)repository{
    self = [super init];
    if (self) {
        _repository = repository;
    }
    return self;
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
