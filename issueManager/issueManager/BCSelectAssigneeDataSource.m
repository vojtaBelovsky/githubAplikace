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
        [_collaborators addObject:[[BCUser alloc] init]];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BCSelectAssigneeCell *cell;    
    if ( indexPath.row == ( _collaborators.count - 1 ) ) {
        cell = [BCSelectAssigneeCell createDeleteCellWithTableView:tableView];
        cell.textLabel.text = NSLocalizedString( @"Unselect assignee", @"" );
    } else {
        BCUser *user = [_collaborators objectAtIndex:indexPath.row];
        cell = [BCSelectAssigneeCell createAssigneCellWithTableView:tableView];
        cell.textLabel.text = user.userLogin;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_isSelectedAssignee){
        return _collaborators.count;
    }else{
        return _collaborators.count-1;
    }
}

@end
