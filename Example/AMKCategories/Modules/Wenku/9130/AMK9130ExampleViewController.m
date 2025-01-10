//
//  AMK9130ExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/10/23.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "AMK9130ExampleViewController.h"
#import "AMK9130PresentedViewController.h"

@interface AMK9130ExampleViewController ()

@end

@implementation AMK9130ExampleViewController

//+ (void)load {
//    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
//        [NSNotificationCenter.defaultCenter removeObserver:token];
//        [UIViewController amk_pushViewController:[self.alloc init] animated:YES];
//    }];
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

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak __typeof__(self)weakSelf = self;
    
    [self.stackView addArrangedButton:@"返回上一页：带动画" controlEvents:UIControlEventTouchUpInside block:^(UIButton* sender) {
        [weakSelf amk_goBackAnimated:YES];
    }];
    [self.stackView addArrangedButton:@"返回上一页：无动画" controlEvents:UIControlEventTouchUpInside block:^(UIButton* sender) {
        [weakSelf amk_goBackAnimated:NO];
    }];
    
    [self.stackView addArrangedSeparatorWithTitle:nil color:UIColor.clearColor size:60];
    [self.stackView addArrangedButton:@"模板库" controlEvents:UIControlEventTouchUpInside block:^(UIButton* sender) {
        AMK9130PresentedViewController *viewController = [AMK9130PresentedViewController.alloc init];
        viewController.view.alpha = 0.4;
        
        UINavigationController *navigationController = [UINavigationController.alloc initWithRootViewController:viewController];
        navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
//        navigationController.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        [UIViewController amk_presentViewController:navigationController animated:YES];
    }];
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

//- (void)rightBarButtonItemClicked:(id)sender {
//    NSString *title = @"相关调试功能";
//    NSString *message = nil;
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"模板库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIViewController *viewController = [UIViewController.alloc init];
//        viewController.
//        
//        
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//    [self presentViewController:alertController animated:YES completion:nil];
//}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
