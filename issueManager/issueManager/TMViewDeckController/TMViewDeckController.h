//
//  TMViewDeckController.h
//
//  Created by Martin Pilch on 4/25/13.
//  Copyright (c) 2013 Martin Pilch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMViewDeckController : UIViewController

@property (nonatomic, strong) UIViewController *centerController;
@property (nonatomic, strong) UIViewController *rightController;
@property (nonatomic, strong) UIViewController *leftController;

@property (assign, readonly) BOOL leftControllerPresented;
@property (assign, readonly) BOOL rightControllerPresented;

- (id)initWithCenterController:(UIViewController *)centerController;

- (void)slideCenterControllerToTheRightWithLeftController:(UIViewController *)leftController animated:(BOOL)animated withCompletion:(void (^) (void))completion;
- (void)slideCenterControllerToTheLeftWithRightController:(UIViewController *)rightController animated:(BOOL)animated withCompletion:(void (^) (void))completion;
- (void)slideCenterControllerBackAnimated:(BOOL)animated withCompletion:(void (^) (void))completion;

@end
