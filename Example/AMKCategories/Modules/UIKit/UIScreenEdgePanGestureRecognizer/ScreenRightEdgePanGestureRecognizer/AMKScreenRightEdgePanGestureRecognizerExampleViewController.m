//
//  AMKScreenRightEdgePanGestureRecognizerExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/4.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMKScreenRightEdgePanGestureRecognizerExampleViewController.h"

@interface AMKScreenRightEdgePanGestureRecognizerExampleViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong, readwrite, nullable) UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer;
@end

@implementation AMKScreenRightEdgePanGestureRecognizerExampleViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:self.screenEdgePanGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Getters & Setters

- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer {
    if (!_screenEdgePanGestureRecognizer) {
        _screenEdgePanGestureRecognizer = [UIScreenEdgePanGestureRecognizer.alloc initWithTarget:self action:@selector(handleScreenEdgePanGestureRecognizer:)];
        _screenEdgePanGestureRecognizer.edges = UIRectEdgeRight;
        _screenEdgePanGestureRecognizer.delegate = self;
    }
    return _screenEdgePanGestureRecognizer;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (void)handleScreenEdgePanGestureRecognizer:(id)sender {
    UIView *view = self.screenEdgePanGestureRecognizer.view;
    CGPoint point = [self.screenEdgePanGestureRecognizer locationInView:view];
    CGFloat distance = point.x - CGRectGetWidth(view.frame);
    NSLog(@"%@", @(distance));
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Helper Methods

@end
