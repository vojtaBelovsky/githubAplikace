//
//  BCaddIssueButton.h
//  issueManager
//
//  Created by Vojtech Belovsky on 7/10/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCaddIssueButton : UITextField

@property UILabel *titleLabel;
@property UIButton *theNewIssuePlus;
@property UIImageView *separatorImgView;
@property (getter = havePlus) BOOL havePlus;

@end
