//
//  BCCollaboratorsDataSource.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCCollaboratorsDataSource : NSObject<UITableViewDataSource>

@property NSArray *collaborators;

- (id)initWithCollaborators:(NSArray *)collaborators;

@end
