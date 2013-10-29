//
//  BCIssueNumberView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 8/2/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//


#define HASH_VERTICAL_OFFSET       ( 2.0f )
#define HASH_HORIZONTAL_OFFSET     ( 6.0f )

#import <UIKit/UIKit.h>

@interface BCIssueNumberView : UIView

@property UIImageView *backgroundRectangle;
@property UILabel *hashNumber;
@property NSNumber *issueNumber;

-(CGSize)countMySize;

@end
