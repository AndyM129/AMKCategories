//
//  AMKRootViewController.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 07/26/2019.
//  Copyright (c) 2019 AndyM129. All rights reserved.
//

#import "AMKRootViewController.h"
#import "AMKExampleTableViewController.h"
#import "AMKExampleViewController.h"
#import "AMKExampleViewModel+AMKRootExampleViewModel.h"

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
    
    AMKExampleViewModel *rootExampleViewModel = AMKExampleViewModel.rootExampleViewModel;
    __block NSMutableArray<UINavigationController *> *viewControllers = [NSMutableArray arrayWithCapacity:rootExampleViewModel.subExamples.count];
    [rootExampleViewModel.subExamples enumerateObjectsUsingBlock:^(AMKExampleViewModel * _Nonnull viewModel, NSUInteger idx, BOOL * _Nonnull stop) {
        AMKExampleTableViewController *exampleTableViewController = [AMKExampleTableViewController.alloc init];
        exampleTableViewController.viewModel = viewModel;
        UINavigationController *navigationController = [UINavigationController.alloc initWithRootViewController:exampleTableViewController];
        [viewControllers addObject:navigationController];
    }];
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
