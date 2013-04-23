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

@interface BCIssueViewController : UIViewController<UITableViewDelegate>{
@private
    BCRepository *_repository;
    NSArray *_issues;
}



@end
