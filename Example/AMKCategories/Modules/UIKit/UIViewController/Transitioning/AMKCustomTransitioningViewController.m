//
//  AMKCustomTransitioningViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/1.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMKCustomTransitioningViewController.h"
#import "WKNEditReaderNewTransitioning.h"

@interface AMKCustomTransitioningViewController () <UINavigationControllerDelegate>

@end

@implementation AMKCustomTransitioningViewController

//+ (void)load {
//    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
//        [NSNotificationCenter.defaultCenter removeObserver:token];
//        [UIViewController amk_pushViewController:AMKCustomTransitioningViewController.new animated:YES];
//    }];
//}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedButton:@"⬅️ PUSH" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        AMKCustomTransitioningViewController *viewController = [AMKCustomTransitioningViewController.alloc init];
        viewController.title = [sender titleForState:UIControlStateNormal];
        weakSelf.navigationController.delegate = viewController.newEditor ? viewController : nil;
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    }];
    [self.stackView addArrangedButton:@"PUSH ➡️" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        AMKCustomTransitioningViewController *viewController = [AMKCustomTransitioningViewController.alloc init];
        viewController.title = [sender titleForState:UIControlStateNormal];
        viewController.newEditor = YES;
        weakSelf.navigationController.delegate = viewController.newEditor ? viewController : nil;
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
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

#pragma mark UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        if ([toVC isKindOfClass:AMKCustomTransitioningViewController.class] && ((AMKCustomTransitioningViewController *)toVC).isNewEditor) {
            return [WKNEditReaderNewTransitioning.alloc initWithOperation:operation];
        }
    } else if (operation == UINavigationControllerOperationPop) {
        if ([fromVC isKindOfClass:AMKCustomTransitioningViewController.class] && ((AMKCustomTransitioningViewController *)fromVC).isNewEditor) {
            return [WKNEditReaderNewTransitioning.alloc initWithOperation:operation];
        }
    }
    return nil;
}

#pragma mark - Helper Methods

@end
