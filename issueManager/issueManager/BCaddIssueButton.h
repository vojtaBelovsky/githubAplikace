//
//  BCaddIssueButton.h
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCMilestone;
@class BCAddIssueContentImgView;
@class BCUser;

@interface BCaddIssueButton : UIButton

@property UILabel *myTitleLabel;
@property UIButton *theNewIssuePlus;
@property CGRect rectOfNewIssuePlus;
@property UIImageView *separatorImgView;
@property UILabel *milestoneLabel;
@property CGRect rectOfMilestoneLabelWithPlus;
@property CGRect rectOfMilestoneLabelWithoutPlus;

@property BCAddIssueContentImgView *assigneImgView;

@property BCAddIssueContentImgView *contentImgView;

-(void) setContentWithAssignee:(BCUser*)assignee;
-(void) setContentWithMilestone:(BCMilestone *)milestone;

- (id)initWithSize:(CGSize)size andTitle:(NSString *)title;
-(void) setMilestoneLabelWithMilestone:(BCMilestone *)milestone;
-(void) setAssigneeLabelWithAssignee:(BCUser*)assignee;

@end
