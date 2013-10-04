//
//  BCNoIssuesView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/23/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCUser;

@interface BCNoIssuesView : UIView

@property UILabel *noIssues;
@property UILabel *userName;

-(void)setUserNameWithText:(NSString *)userName;

@end
