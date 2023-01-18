//
//  AMKLifeCircleTabBarController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/12/29.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKLifeCircleTabBarController.h"
#import "AMKLifeCircleTabBarItemViewController.h"

@interface AMKLifeCircleTabBarController ()

@end

@implementation AMKLifeCircleTabBarController

//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIApplication.sharedApplication.delegate.window.rootViewController = self.new;
//    });
//}

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
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewControllers = @[
        [self childNavigationControllerWithTitle:@"消息"],
        [self childNavigationControllerWithTitle:@"通讯录"],
        [self childNavigationControllerWithTitle:@"发现"],
        [self childNavigationControllerWithTitle:@"我"],
    ];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"🏠⭕️");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"🏠🚫");
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

- (UINavigationController *)childNavigationControllerWithTitle:(NSString *)title {
    AMKLifeCircleTabBarItemViewController *viewController = [AMKLifeCircleTabBarItemViewController.alloc init];
    viewController.title = title;
    UINavigationController *navigationController = [UINavigationController.alloc initWithRootViewController:viewController];
    return navigationController;
}

@end
