//
//  BCViewController.m
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/18/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCHTTPClient.h"
#import "BCIssue.h"
//#import "BCRepositoryViewController.h"

@interface BCViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation BCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //BCRepositoryViewController *repoController = [[BCRepositoryViewController alloc] initWithStyle:UITableViewStylePlain];
    //[self pushViewController:repoController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (IBAction)getIssue:(id)sender {
    
    [[BCHTTPClient sharedInstance] getPath:@"user/issues" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSArray *response = [NSArray arrayWithArray:responseObject];
        
        NSMutableArray *issues = [NSMutableArray arrayWithCapacity:[response count]];
        
        for (NSDictionary *object in response) {
            [issues addObject:[MTLJSONAdapter modelOfClass:[BCIssue class] fromJSONDictionary:object error:nil]];
        }
        NSLog(@"%@", ((BCIssue*)issues[1]).title);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"fail");
    }];
}

- (IBAction)getRepository:(id)sender {
    [[BCHTTPClient sharedInstance] getPath:@"user/repos" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSArray *response = [NSArray arrayWithArray:responseObject];
        
        NSMutableArray *repositories = [NSMutableArray arrayWithCapacity:[response count]];
        
        for (NSDictionary *object in response) {
            [repositories addObject:[MTLJSONAdapter modelOfClass:[BCRepository class] fromJSONDictionary:object error:nil]];
        }
        NSLog(@"%@", ((BCRepository*)repositories[1]).name);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"fail");
    }];
    
}
  */
@end









