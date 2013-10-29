//
//  BCRepositoryView.h
//  Bakalarka1
//
//  Created by Vojtech Belovsky on 3/28/13.
//  Copyright (c) 2013 vojta. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface BCRepositoryView : UIView {
    
}

@property UIView *navBarView;
@property (readonly) UITableView *tableView;
@property UIImageView *backgroundImageView;
@property UILabel *repositoryLabel;
@property UILabel *repositoryLabelShadow;
@property UIButton *confirmButton;
@property UIActivityIndicatorView *activityIndicatorView;

- (id)initWithButtonTitle:(NSString*)title ;

@end
