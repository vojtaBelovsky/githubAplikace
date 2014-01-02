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
#import "BCAvatarImgView.h"

#define PLACEHOLDER_IMG     [UIImage imageNamed:@"gravatar-user-420.png"]

@implementation BCSelectAssigneeDataSource

//Inicializace data sourcu, na začátku vytvoříme pole, které naplníme spolupracovníky
- (id)initWithCollaborators:(NSArray *)collaborators
{
  self = [super init];
  if (self) {
    _collaborators = [[NSMutableArray alloc] initWithArray:collaborators];
  }
  return self;
}

//Metoda, kterou musí implementovat každý objekt, jenž je v souladu s UITableViewDataSource protokolem
//Tato metoda vrací objekt typu UITableViewCell (v mém případě jeho potomka), který se zobrazí
//na dané pozici - podle parametru indexPaths
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  //Vytvoření řádku tabulky a získání entity uživatele pro tento řádek
  BCSelectAssigneeCell *cell = [BCSelectAssigneeCell createAssigneCellWithTableView:tableView];
  BCUser *user = [_collaborators objectAtIndex:indexPath.row];
  
  //Nastavení avatara a uživatelského jména pro daný řádek
  [cell.avatarImgView setImageWithURL:user.avatarUrl placeholderImage:PLACEHOLDER_IMG];
  cell.myTextLabel.text = user.userLogin;
  
  return cell;
}

//Metoda, kterou musí implementovat každý objekt, jenž je v souladu s UITableViewDataSource protokolem
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return _collaborators.count;
}

@end
