//
//  TMViewDeckController.m
//
//  Created by Martin Pilch on 4/25/13.
//  Copyright (c) 2013 Martin Pilch. All rights reserved.
//

#import "TMViewDeckController.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration 0.3f
#define kControllerOverlap 45.0f

@interface TMViewDeckController ()

@end

@implementation TMViewDeckController

- (id)initWithCenterController:(UIViewController *)centerController {

  self = [super init];
  if (self) {
    self.centerController = centerController;
  }
  return self;
}

- (void)loadView {
  
  [super loadView];
  
  [self setAndPresentCenterController:_centerController];
}

#pragma mark -
#pragma mark Properties

- (void)setRightController:(UIViewController *)rightController {
  
  [_rightController removeFromParentViewController];
  [_rightController.view removeFromSuperview];
  
  if ( rightController ) {
    [self addChildViewController:rightController];
    [rightController didMoveToParentViewController:self];
    
    CGRect frame = self.view.bounds;
    frame.origin.x = kControllerOverlap;
    frame.size.width -= kControllerOverlap;
    rightController.view.frame = frame;
    
    [self.view insertSubview:rightController.view belowSubview:_centerController.view];
  }
  
  _rightController = rightController;
}

- (void)setLeftController:(UIViewController *)leftController {
  
  [_leftController removeFromParentViewController];
  [_leftController.view removeFromSuperview];
  
  if ( leftController ) {
    [self addChildViewController:leftController];
    [leftController didMoveToParentViewController:self];
    
    CGRect frame = self.view.bounds;
    frame.size.width -= kControllerOverlap;
    leftController.view.frame = frame;
    
    [self.view insertSubview:leftController.view belowSubview:_centerController.view];
  }
  
  _leftController = leftController;
}

- (void)setAndPresentCenterController:(UIViewController *)centerController {
  
  UIView *previousView = self.centerController.view;
  self.centerController = centerController;
  
  [self addChildViewController:centerController];
  [centerController didMoveToParentViewController:self];
  
  CGRect frame = self.view.bounds;
  centerController.view.frame = frame;

  [centerController.view setAlpha:0];
  [self.view addSubview:centerController.view];
  [UIView animateWithDuration:0.5 animations:^{
    [previousView setAlpha:0];
    [centerController.view setAlpha:1];
  }];


  
//  [self addChildViewController:centerController];
//  [_centerController willMoveToParentViewController:nil];
//  
//  [self transitionFromViewController:_centerController toViewController:centerController duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
//    
//  } completion:^(BOOL finished) {
//    [_centerController removeFromParentViewController];
//    [centerController didMoveToParentViewController:self];
//    _centerController = centerController;
//  }];
  
//  [_centerController.view removeFromSuperview];
//  
//  _centerController = centerController;
//  [self addChildViewController:centerController];
//  [centerController didMoveToParentViewController:self];
//  
//  CGRect frame = self.view.bounds;
//  centerController.view.frame = frame;
//  [self.view addSubview:centerController.view];
  
}

#pragma mark -
#pragma mark Private

- (void)presentCenterController:(UIViewController *)centerController {
  
//  self.centerController = centerController;
//  
//  [self addChildViewController:centerController];
//  [centerController didMoveToParentViewController:self];
//  
//  CGRect frame = self.view.bounds;
//  centerController.view.frame = frame;
//  
//  [self.view addSubview:centerController.view];  
}

#pragma mark -
#pragma mark Public

- (void)slideCenterControllerToTheRightWithLeftController:(UIViewController *)leftController animated:(BOOL)animated withCompletion:(void (^) (void))completion {
  
  if ( _leftControllerPresented ) {
    return;
  }
  
  self.leftController = leftController;
  
  _centerController.view.layer.shadowOffset = CGSizeMake(-1, 0);
  _centerController.view.layer.shadowRadius = 5.0f;
  _centerController.view.layer.shadowOpacity = 0.5f;
  _centerController.view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:_centerController.view.bounds] CGPath];
  
  [UIView animateWithDuration:animated ? kAnimationDuration : 0.0f delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^ {
    
    CGRect newFrame = _centerController.view.frame;
    newFrame.origin.x = CGRectGetWidth(newFrame) - kControllerOverlap;
    _centerController.view.frame = newFrame;
    
  } completion:^(BOOL finished) {
    
    _leftControllerPresented = YES;
    
    if ( completion ) {
      completion();
    }
  }];
  
}

- (void)slideCenterControllerToTheLeftWithRightController:(UIViewController *)rightController animated:(BOOL)animated withCompletion:(void (^) (void))completion {
  
  if ( _rightControllerPresented ) {
    return;
  }
  
  self.rightController = rightController;
  
  _centerController.view.layer.shadowOffset = CGSizeMake(-1, 0);
  _centerController.view.layer.shadowRadius = 5.0f;
  _centerController.view.layer.shadowOpacity = 0.5f;
  _centerController.view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:_centerController.view.bounds] CGPath];
  
  [UIView animateWithDuration:animated ? kAnimationDuration : 0.0f delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^ {
    
    CGRect newFrame = _centerController.view.frame;
    newFrame.origin.x = -CGRectGetWidth(newFrame) + kControllerOverlap;
    _centerController.view.frame = newFrame;
    
  } completion:^(BOOL finished) {
    
    _rightControllerPresented = YES;
    
    if ( completion ) {
      completion();
    }
  }];
  
}

- (void)slideCenterControllerBackAnimated:(BOOL)animated withCompletion:(void (^) (void))completion {
  
  _centerController.view.layer.shadowOffset = CGSizeMake(-1, 0);
  _centerController.view.layer.shadowRadius = 5.0f;
  _centerController.view.layer.shadowOpacity = 0.5f;
  _centerController.view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:_centerController.view.bounds] CGPath];
  
  [UIView animateWithDuration:animated ? kAnimationDuration : 0.0f delay:0.0f options:UIViewAnimationCurveEaseInOut animations:^ {
    
    CGRect newFrame = _centerController.view.frame;
    newFrame.origin.x = 0.0f;
    _centerController.view.frame = newFrame;
    
  } completion:^(BOOL finished) {
    
    _centerController.view.layer.shadowOffset = CGSizeZero;
    _centerController.view.layer.shadowRadius = 0.0f;
    _centerController.view.layer.shadowOpacity = 0.0f;
    
    _leftControllerPresented = NO;
    _rightControllerPresented = NO;
    
    if ( completion ) {
      completion();
    }
  }];
  
}

@end
