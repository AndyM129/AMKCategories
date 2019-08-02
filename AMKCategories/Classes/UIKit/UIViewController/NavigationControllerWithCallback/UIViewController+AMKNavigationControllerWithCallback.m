//
//  UIViewController+AMKNavigationControllerWithCallback.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/8/3.
//

#import "UIViewController+AMKNavigationControllerWithCallback.h"
#import <objc/runtime.h>

@implementation UIViewController (AMKNavigationControllerWithCallback)

#pragma mark - Init Methods

#pragma mark - Properties

- (BOOL)amk_removeFromParentViewControllerWhenDisappeared {
    return [objc_getAssociatedObject(self, @selector(amk_removeFromParentViewControllerWhenDisappeared)) boolValue];
}

- (void)setAmk_removeFromParentViewControllerWhenDisappeared:(BOOL)amk_removeFromParentViewControllerWhenDisappeared {
    objc_setAssociatedObject(self, @selector(amk_removeFromParentViewControllerWhenDisappeared), @(amk_removeFromParentViewControllerWhenDisappeared), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public Methods

+ (BOOL)amk_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(UIViewController *))completion {
    return [[self amk_topViewController] amk_pushViewController:viewController animated:animated completion:completion];
}

- (BOOL)amk_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(UIViewController *))completion {
    return [self amk_gotoViewController:viewController transitionStyle:AMKViewControllerTransitionStylePush animated:animated completion:completion];
}

+ (BOOL)amk_presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(UIViewController *))completion {
    return [[self amk_topViewController] amk_presentViewController:viewController animated:animated completion:completion];
}

- (BOOL)amk_presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(UIViewController *))completion {
    return [self amk_gotoViewController:viewController transitionStyle:AMKViewControllerTransitionStylePresent animated:animated completion:completion];
}

+ (BOOL)amk_gotoViewController:(UIViewController *)viewController transitionStyle:(AMKViewControllerTransitionStyle)transitionStyle animated:(BOOL)animated completion:(void (^)(UIViewController *))completion {
    return [[self amk_topViewController] amk_gotoViewController:viewController transitionStyle:transitionStyle animated:animated completion:completion];
}

- (BOOL)amk_gotoViewController:(UIViewController *)viewController transitionStyle:(AMKViewControllerTransitionStyle)transitionStyle animated:(BOOL)animated completion:(void (^)(UIViewController *))completion {
    __weak __typeof(self) weakSelf = self;
    [viewController setAmk_viewDidAppearBlock:^(UIViewController *viewController, BOOL animated){
        if (weakSelf.amk_removeFromParentViewControllerWhenDisappeared && weakSelf.parentViewController) [weakSelf removeFromParentViewController];
        if (completion) completion(viewController);
        viewController.amk_viewDidAppearBlock = NULL;
    }];
    
    if (transitionStyle == AMKViewControllerTransitionStylePresent) {
        if (viewController.amk_presentedWithNavigationController) {
            viewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        if (self.amk_removeFromParentViewControllerWhenDisappeared && !self.parentViewController) {
            __block UIViewController *presentingViewController = self.presentingViewController;
            [self dismissViewControllerAnimated:animated completion:^{
                [presentingViewController presentViewController:viewController animated:animated completion:NULL];
            }];
        } else {
            [self presentViewController:viewController animated:animated completion:NULL];
        }
        return YES;
    }
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController*)self pushViewController:viewController animated:animated];
        return YES;
    }
    if (self.navigationController) {
        [self.navigationController pushViewController:viewController animated:animated];
        return YES;
    }
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:viewController animated:animated];
        return YES;
    }
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *rootViewController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UIViewController *selectedViewController = rootViewController.selectedViewController;
        if ([selectedViewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)selectedViewController pushViewController:viewController animated:animated];
            return YES;
        }
        if (selectedViewController.navigationController) {
            [selectedViewController.navigationController pushViewController:viewController animated:animated];
            return YES;
        }
    }
    
    NSAssert(NO, @"self %@ can not push view controller %@", self, viewController);
    return NO;
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
