//
//  BCSelectAssigneeViewController.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCSelectAssigneeViewController.h"
#import "BCSelectAssigneeDataSource.h"
#import "BCSelectAssigneeView.h"
#import "BCAddIssueViewController.h"

@implementation BCSelectAssigneeViewController

#pragma mark -
#pragma mark lifecycles

- (id)initWithController:(BCAddIssueViewController *)controller
{
  self = [super init];
  if (self) {
    _controller = controller;
  }
  return self;
}

//v této metodě voláme všechny dosud vytvořené komponenty pro zobrazení tabulky
//pro výběr spolupracovníka.
-(void)loadView{
  _selectAssigneView = [[BCSelectAssigneeView alloc] init];
  [_selectAssigneView.tableView setDelegate:self];
  [self setView:_selectAssigneView];
  [_selectAssigneView.doneButton addTarget:self action:@selector(doneButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [_selectAssigneView.cancelButton addTarget:self action:@selector(cancelButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
  [self createModelWithCollaborators:_controller.collaborators withCheckedAssignee:_controller.checkedAssignee];
}

#pragma mark -
#pragma mark private

//Zde vytváříme data source.
-(void)createModelWithCollaborators:(NSArray*)assignees withCheckedAssignee:(BCUser*)checkedAssignee{
  _dataSource = [[BCSelectAssigneeDataSource alloc] initWithCollaborators:assignees];
  [_selectAssigneView.tableView setDataSource:_dataSource];
  [_selectAssigneView.tableView reloadData];
  [_selectAssigneView setNeedsLayout];
  if(checkedAssignee == nil){
    _checkedAssignee = nil;
  }else{
    _checkedAssignee = [self getIndexPathOfAssignee:checkedAssignee];
    [_selectAssigneView.tableView selectRowAtIndexPath:_checkedAssignee animated:YES scrollPosition:UITableViewScrollPositionMiddle];
  }
}

//Pomocná metoda.
-(NSIndexPath*)getIndexPathOfAssignee:(BCUser*)assignee{
  NSUInteger row = [_dataSource.collaborators indexOfObject:assignee];
  return [NSIndexPath indexPathForRow:row inSection:0];
}

#pragma mark -
#pragma mark buttonActions

//Implementace akce zpět
-(void) cancelButtonDidPress{
  [self.navigationController popViewControllerAnimated:YES];
}

//Implementace akce done, nejdříve přiřadíme nového spolupracovníka k úkolu (nebo žádného,
//jako reprezentaci toho, že k úkolu není nikdo přiřazen). Potom přejdeme zpět na předchozí
//obrazovku
-(void) doneButtonDidPress{
  if (_checkedAssignee == nil) {
    [_controller setCheckedAssignee:nil];
  }else{
    [_controller setCheckedAssignee:[_dataSource.collaborators objectAtIndex:_checkedAssignee.row]];
  }
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark tableView

//Implementace této metody mi zajištuje správné chování při vybírání buňek (zaškrtávání).
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if (_checkedAssignee == nil) {
    _checkedAssignee = indexPath;
  }else{
    if (_checkedAssignee.row == indexPath.row) {
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
      _checkedAssignee = nil;
    }else{
      [[tableView cellForRowAtIndexPath:_checkedAssignee] setSelected:NO];
      _checkedAssignee = indexPath;
    }
  }
}

@end
