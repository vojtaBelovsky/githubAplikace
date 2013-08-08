//
//  BCHeadeView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/7/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCMilestone;

@interface BCHeadeView : UIView

@property UILabel *title;
@property UILabel *dueIn;

- (id)initWithFrame:(CGRect)frame andMilestone:(BCMilestone *)milestone;

@end
