//
//  BCIssueDataSource.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCIssueDataSource : NSObject<UITableViewDataSource>

@property (copy) NSArray *issues;

-(id) initWithIssues:(NSArray *)issues;

@end
