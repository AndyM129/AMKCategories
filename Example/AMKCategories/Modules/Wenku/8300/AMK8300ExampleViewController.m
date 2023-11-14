//
//  AMK8300ExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/11/13.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMK8300ExampleViewController.h"
#import "AMKRootViewController.h"
#import <AMKCategories/MBProgressHUD+AMKCategories.h>

static NSInteger kIndex = 0;

@interface AMK8300ExampleViewController ()

@end

@implementation AMK8300ExampleViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = [NSString stringWithFormat:@"%@ - %ld", NSStringFromClass(self.class), ++kIndex];
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor ?: [UIColor whiteColor];
    
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedButton:@"跳转新页面" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        AMK8300ExampleViewController *viewController = [AMK8300ExampleViewController.alloc init];
        [UIViewController amk_pushViewController:viewController animated:YES];
    }];
    [self.stackView addArrangedButton:@"打开弹窗页" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        AMK8300ExampleViewController *viewController = [AMK8300ExampleViewController.alloc init];
        viewController.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:.8];
        [viewController setAmk_viewDidAppearBlock:^(__kindof UIViewController * _Nonnull viewController, BOOL animated) {
            [viewController.navigationController setNavigationBarHidden:YES animated:animated];
        }];
        [viewController setAmk_viewDidDisappearBlock:^(__kindof UIViewController * _Nonnull viewController, BOOL animated) {
            [viewController.navigationController setNavigationBarHidden:NO animated:animated];
        }];
        UINavigationController *navigationController = [UINavigationController.alloc initWithRootViewController:viewController];
        navigationController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [UIViewController amk_presentViewController:navigationController animated:YES];
    }];
    [self.stackView addArrangedButton:@"移除前1页面" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        AMK8300ExampleViewController *previousViewController = (id)weakSelf.amk_previousViewController;
        [previousViewController amk_removeFromParentViewController];
    }];
    [self.stackView addArrangedButton:@"移除前2页面" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        AMK8300ExampleViewController *previousViewController = (id)weakSelf.amk_previousViewController.amk_previousViewController;
        [previousViewController amk_removeFromParentViewController];
    }];
    [self.stackView addArrangedButton:@"关闭当前页" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf amk_goBack];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [MBProgressHUD amk_showTextHUDWithTitle:@"当前页面" message:self.description inView:nil responder:nil duration:3 animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([UIViewController.amk_topViewController isKindOfClass:AMKRootViewController.class]) {
        kIndex = 0;
    }
}

#pragma mark - Getters & Setters

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", super.description, self.title];
}

- (NSString *)debugDescription {
    return self.description;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (void)amk_removeFromParentViewController {
    [MBProgressHUD amk_showTextHUDWithTitle:@"从导航栈中移除页面" message:self.description inView:nil responder:nil duration:3 animated:YES];

    UINavigationController *navigationController = self.navigationController;
    if (navigationController.viewControllers.count <= 1) {
        [self dismissViewControllerAnimated:NO completion:nil];
    } else {
        NSMutableArray<UIViewController *> *viewControllers = navigationController.viewControllers.mutableCopy;
        [viewControllers removeObject:self];
        navigationController.viewControllers = viewControllers;
    }
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
