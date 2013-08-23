//
//  BCCollaboratorsDataSource.m
//  issueManager
//
//  Created by Vojtech Belovsky on 8/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCCollaboratorsDataSource.h"
#import "BCCollaboratorsCell.h"
#import "UIImageView+AFNetworking.h"
#import "BCUser.h"
#import "BCAvatarImgView.h"

#define PLACEHOLDER_IMG     [UIImage imageNamed:@"gravatar-user-420.png"]
#define COLLABORATORS_MASK  [UIImage imageNamed:@"user-mask.png"]

@implementation BCCollaboratorsDataSource

- (id)initWithCollaborators:(NSArray *)collaborators
{
  self = [super init];
  if (self) {
    _collaborators = collaborators;
  }
  
  return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  BCCollaboratorsCell *cell = [BCCollaboratorsCell createCollaboratorCell:tableView];
  BCUser *user = [_collaborators objectAtIndex:indexPath.row];
  [cell.myTextLabel setText:user.userLogin];
  [cell.avatarImgView setImageWithURL:user.avatarUrl placeholderImage:PLACEHOLDER_IMG];
  [cell.avatarImgView.maskImageView setImage:COLLABORATORS_MASK];
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_collaborators count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

@end
