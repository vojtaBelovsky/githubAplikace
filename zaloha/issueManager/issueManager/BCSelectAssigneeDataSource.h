//
//  BCSelectAssigneeDataSource.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCSelectAssigneeDataSource : NSObject<UITableViewDataSource> 


@property NSMutableArray *collaborators;

- (id)initWithCollaborators:(NSArray *)collaborators;

@end
