//
//  BCAddIssueContentImgView.h
//  issueManager
//
//  Created by Vojtech Belovsky on 7/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCAddIssueContentImgView : UIImageView

@property UILabel *myTextLabel;
@property UIImageView *backgroundImgView;

-(void)setMyTextLabelWitText:(NSString *)text;

@end
