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
#import "UIImageView+AFNetworking.h"

#define PLACEHOLDER_IMG     [UIImage imageNamed:@"gravatar-user-420.png"]

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
  BCUser *user = [_collaborators objectAtIndex:indexPath.row];
  cell = [BCSelectAssigneeCell createAssigneCellWithTableView:tableView];
  [cell.avatarImgView setImageWithURL:user.avatarUrl placeholderImage:PLACEHOLDER_IMG];
  cell.myTextLabel.text = user.userLogin;
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return _collaborators.count;
}

@end
