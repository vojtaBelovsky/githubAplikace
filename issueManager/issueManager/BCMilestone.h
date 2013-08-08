//
//  BCMilestone.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/22/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface BCMilestone : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSNumber *milestoneId;
@property (nonatomic, copy, readonly) NSNumber *number;
@property (nonatomic, copy, readonly) NSDate *dueOn;

@end
