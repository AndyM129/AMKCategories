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
        exampleTableViewController.tabBarItem.image = [self tabBarItemImageWithViewModel:viewModel];
        
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

- (UIImage *)tabBarItemImageWithViewModel:(AMKExampleViewModel *)viewModel {
    static NSMutableDictionary *map = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{}.mutableCopy;
        map[@"基础组件"] = @"wkn_widget_example_tabbar_basic";
        map[@"接口能力"] = @"wkn_widget_example_tabbar_api";
        map[@"其他"] = @"wkn_widget_example_tabbar_others";
    });
    
    NSString *imageName = [map objectForKey:viewModel.title];
    UIImage *image = !imageName.length ? nil : [UIImage imageNamed:imageName];
    if (!image) {
        image = [UIImage imageWithColor:self.view.tintColor size:CGSizeMake(25, 25)];
    }
    return image;
}

@end
