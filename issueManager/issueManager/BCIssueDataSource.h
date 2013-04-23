//
//  BCIssueDataSource.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCIssueDataSource : NSObject<UITableViewDataSource>{
@private
    NSArray *_issues;
}

@end
