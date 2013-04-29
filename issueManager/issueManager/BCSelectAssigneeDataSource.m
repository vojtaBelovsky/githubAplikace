//
//  BCSelectAssigneeDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeDataSource.h"
#import "BCSelectAssigneeCell.h"

@implementation BCSelectAssigneeDataSource

- (id)initWithCollaborators:(NSArray *)collaborators
{
    self = [super init];
    if (self) {
        _collaborators = collaborators;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[BCSelectAssigneeCell alloc] initWithAssignee:[_collaborators objectAtIndex:indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_collaborators count];
}

@end
