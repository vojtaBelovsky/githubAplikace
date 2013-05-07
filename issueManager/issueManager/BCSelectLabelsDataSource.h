//
//  BCSelectLabelsDataSource.h
//  issueManager
//
//  Created by Vojtech Belovsky on 5/6/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCSelectLabelsDataSource : NSObject<UITableViewDataSource>

@property NSArray *labels;

- (id)initWithLables:(NSArray *)labels;

@end
