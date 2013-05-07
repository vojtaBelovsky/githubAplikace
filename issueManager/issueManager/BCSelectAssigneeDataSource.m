//
//  BCSelectAssigneeDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeDataSource.h"
#import "BCSelectAssigneeCell.h"
#import "BCUser.h"

@implementation BCSelectAssigneeDataSource

- (id)initWithCollaborators:(NSArray *)collaborators
{
    self = [super init];
    if (self) {
        _collaborators = [[NSMutableArray alloc] initWithArray:collaborators];
        [_collaborators addObject:[NSNull null]];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BCSelectAssigneeCell *cell;    
    if ( indexPath.row == ( _collaborators.count - 1 ) ) {
        cell = [BCSelectAssigneeCell createDeleteCellWithTableView:tableView];
        cell.textLabel.text = NSLocalizedString( @"Unselect assagnee", @"" );
    } else {
        BCUser *user = [_collaborators objectAtIndex:indexPath.row];
        cell = [BCSelectAssigneeCell createAssigneCellWithTableView:tableView];
        cell.textLabel.text = user.userLogin;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _collaborators.count;
}

@end
