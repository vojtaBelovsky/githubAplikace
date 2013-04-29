//
//  BCSelectAssigneeCell.h
//  issueManager
//
//  Created by Vojtech Belovsky on 4/29/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BCUser;

@interface BCSelectAssigneeCell : UITableViewCell

- (id)initWithAssignee:(BCUser *)assignee;

@end
