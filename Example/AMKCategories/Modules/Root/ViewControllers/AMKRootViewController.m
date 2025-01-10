//
//  AMKRootViewController.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 07/26/2019.
//  Copyright (c) 2019 AndyM129. All rights reserved.
//

#import "AMKRootViewController.h"
#import "AMKExamplesTableViewController.h"
#import "AMKExampleViewController.h"
#import "AMKRootExampleModel.h"

@interface AMKRootViewController ()

@end

@implementation AMKRootViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    NSMutableArray<UINavigationController *> *viewControllers = @[].mutableCopy;
    [viewControllers addObject:[UINavigationController.alloc initWithRootViewController:[AMKExamplesTableViewController.alloc init]]];
    [viewControllers addObject:[UINavigationController.alloc initWithRootViewController:[AMKExamplesTableViewController.alloc init]]];
    [viewControllers addObject:[UINavigationController.alloc initWithRootViewController:[AMKExamplesTableViewController.alloc init]]];
    [viewControllers addObject:[UINavigationController.alloc initWithRootViewController:[AMKExamplesTableViewController.alloc init]]];
    self.viewControllers = viewControllers;
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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
