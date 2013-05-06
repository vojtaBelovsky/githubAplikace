//
//  BCSelectMilestoneDataSource.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/3/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCSelectMilestoneDataSource : NSObject<UITableViewDataSource>

@property NSArray *milestones;

- (id)initWithMilestones:(NSArray *)milestones;

@end
