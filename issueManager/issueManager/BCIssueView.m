//
//  BCIssueView.m
//  issueManager
//
//  Created by Vojtech Belovsky on 4/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import "BCIssueView.h"
#import <QuartzCore/QuartzCore.h>

#define BACKGROUND_IMAGE              [UIImage imageNamed:@"appBackground.png"]
#define NAV_BAR_HEIGHT                ( 44.0f )
#define OFFSET                        ( 6.0f )
#define USER_NAME_FONT                [UIFont fontWithName:@"ProximaNova-Regular" size:18]
#define REPO_NAME_FONT                [UIFont fontWithName:@"ProximaNovaCond-Light" size:15]
#define USER_NAME_FONT_COLOR          [UIColor colorWithRed:.32 green:.32 blue:.32 alpha:1.00];
#define REPO_NAME_FONT_COLOR          [UIColor colorWithRed:.52 green:.52 blue:.52 alpha:1.00];
#define USER_NAME_SHADOW_FONT_COLOR   [UIColor whiteColor]
#define ADD_NEW_ISSUE_IMAGE           [UIImage imageNamed:@"profileNavbarPlusOff.png"]
#define ADD_NEW_ISSUE_HL_IMAGE        [UIImage imageNamed:@"profileNavbarPlusOn.png"]

#define CHOOSE_COLLABORATOR_IMAGE         [UIImage imageNamed:@"profileNavbarPplOff.png"]
#define CHOOSE_COLLABORATOR_HL_IMAGE      [UIImage imageNamed:@"profileNavbarPplOn.png"]

@implementation BCIssueView

-(id)initWithNumberOfRepos:(int)numberOfRepos{
    self = [super init];
    if(self){
      _numberOfRepos = numberOfRepos;
      UIImage *resizableImage = [BACKGROUND_IMAGE stretchableImageWithLeftCapWidth:5 topCapHeight:64];
      _backgroundImageView = [[UIImageView alloc] initWithImage:resizableImage];
      [self addSubview:_backgroundImageView];
      
      _navigationBarView = [[UIImageView alloc] init];
      [_navigationBarView setBackgroundColor:[UIColor clearColor]];
      [self addSubview:_navigationBarView];
      
      _userNameLabel = [[UILabel alloc] init];
      _userNameLabel.numberOfLines = 0;
      _userNameLabel.font = USER_NAME_FONT;
      _userNameLabel.textColor = USER_NAME_FONT_COLOR;
      _userNameLabel.backgroundColor = [UIColor clearColor];
      _userNameLabel.layer.shadowOpacity = 1.0;
      _userNameLabel.layer.shadowRadius = 0.0;
      _userNameLabel.layer.shadowColor = USER_NAME_SHADOW_FONT_COLOR.CGColor;
      _userNameLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
      [self addSubview:_userNameLabel];
      
      _repositoryNameLabel = [[UILabel alloc] init];
      _repositoryNameLabel.numberOfLines = 0;
      _repositoryNameLabel.font = REPO_NAME_FONT;
      _repositoryNameLabel.textColor = REPO_NAME_FONT_COLOR;
      _repositoryNameLabel.backgroundColor = [UIColor clearColor];
      _repositoryNameLabel.layer.shadowOpacity = 1.0;
      _repositoryNameLabel.layer.shadowRadius = 0.0;
      _repositoryNameLabel.layer.shadowColor = USER_NAME_SHADOW_FONT_COLOR.CGColor;
      _repositoryNameLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
      [self addSubview:_repositoryNameLabel];
      
      _chooseCollaboratorButton = [[UIButton alloc] init];
      [_chooseCollaboratorButton setImage:CHOOSE_COLLABORATOR_IMAGE forState:UIControlStateNormal];
      [_chooseCollaboratorButton setImage:CHOOSE_COLLABORATOR_HL_IMAGE forState:UIControlStateSelected];
      [self addSubview:_chooseCollaboratorButton];
      
      _addNewIssueButton = [[UIButton alloc] init];
      [_addNewIssueButton setImage:ADD_NEW_ISSUE_IMAGE forState:UIControlStateNormal];
      [_addNewIssueButton setImage:ADD_NEW_ISSUE_HL_IMAGE forState:UIControlStateSelected];
      [self addSubview:_addNewIssueButton];
      
      _tableViews = [[UIScrollView alloc] init];
      [_tableViews setPagingEnabled:YES];
      [_tableViews setBackgroundColor:[UIColor clearColor]];
      [self addSubview:_tableViews];
      
      _allTableViews = [[NSMutableArray alloc] initWithCapacity:_numberOfRepos];
      UITableView *currentTableView;
      for (int i = 0; i < _numberOfRepos; i++) {
        currentTableView = [[UITableView alloc] init];
        [currentTableView setBackgroundColor:[UIColor clearColor]];
        [currentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_allTableViews addObject:currentTableView];
        [_tableViews addSubview:currentTableView];
      }
    }
    return self;
}

#pragma mark - public
-(void)setUserName:(NSString *)userName{
  [self.userNameLabel setText:userName];
}

-(void)setRepoName:(NSString *)repoName{
  [UIView animateWithDuration:0.1f animations:^{
    [self.repositoryNameLabel setAlpha:0.0f];
  } completion:^(BOOL finished) {
    if (finished) {
      [self.repositoryNameLabel setText:repoName];
      [self setNeedsLayout];
      [UIView animateWithDuration:0.2f animations:^{
        [self.repositoryNameLabel setAlpha:1.0f];
      } completion:^(BOOL finished) {
      }];
    }
  }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
  
  CGRect frame= CGRectZero;
  frame.size = self.frame.size;
  if ( !CGRectEqualToRect( frame, _backgroundImageView.frame ) ) {
    _backgroundImageView.frame = frame;
  }
  
  frame = CGRectMake(0, 0, self.frame.size.width, NAV_BAR_HEIGHT);
  if(! CGRectEqualToRect(_navigationBarView.frame, frame)){
    _navigationBarView.frame = frame;
  }
  
  frame.size = [_chooseCollaboratorButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_chooseCollaboratorButton.frame, frame)){
    _chooseCollaboratorButton.frame = frame;
  }
  
  frame.size = [_userNameLabel sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(((self.frame.size.width-frame.size.width)/2), ((self.navigationBarView.frame.size.height-frame.size.height)/2)-OFFSET);
  if( !CGRectEqualToRect(_userNameLabel.frame, frame)){
    _userNameLabel.frame = frame;
  }
  
  frame.size = [_repositoryNameLabel sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake(((self.frame.size.width-frame.size.width)/2), _userNameLabel.frame.origin.y+_userNameLabel.frame.size.height);
  if( !CGRectEqualToRect(_repositoryNameLabel.frame, frame)){
    _repositoryNameLabel.frame = frame;
  }
  
  frame.size = [_addNewIssueButton sizeThatFits:_navigationBarView.frame.size];
  frame.origin = CGPointMake((_navigationBarView.frame.size.width-frame.size.width)-15, (_navigationBarView.frame.size.height-frame.size.height)/2);
  if(! CGRectEqualToRect(_addNewIssueButton.frame, frame)){
    _addNewIssueButton.frame = frame;
  }
    
  frame = CGRectMake(0, _navigationBarView.frame.size.height, self.frame.size.width, self.frame.size.height-_navigationBarView.frame.size.height);
  if(!CGRectEqualToRect(frame, _tableViews.frame)){
    _tableViews.frame = frame;
  }
  
  frame = CGRectMake(0, _navigationBarView.frame.size.height, self.frame.size.width*_numberOfRepos, self.frame.size.height-_navigationBarView.frame.size.height);
  if (!CGSizeEqualToSize(_tableViews.contentSize, frame.size)) {
    _tableViews.contentSize = frame.size;
  }
  
  frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-NAV_BAR_HEIGHT);
  for (int i = 0; i < _numberOfRepos; i++) {
    frame.origin.x = i*frame.size.width;
    [[_allTableViews objectAtIndex:i] setFrame:frame];
  }
}

@end
