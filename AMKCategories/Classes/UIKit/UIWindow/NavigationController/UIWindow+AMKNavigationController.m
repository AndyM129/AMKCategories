//
//  UIWindow+AMKNavigationController.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/12/20.
//

#import "UIWindow+AMKNavigationController.h"

@implementation UIWindow (AMKNavigationController)

#pragma mark - Init Methods

#pragma mark - Properties

+ (UIViewController *)amk_topViewController {
    return UIApplication.sharedApplication.keyWindow.amk_topViewController;
}

- (UIViewController *)amk_topViewController {
    UIViewController *topViewController = self.rootViewController;
    while (YES) {
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            topViewController = [(UITabBarController *)topViewController selectedViewController];
        } else if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

#pragma mark - Layout Subviews

#pragma mark - Public Methods

- (BOOL)amk_gotoRootViewControllerAnimated:(BOOL)animated {
    // 移除模态视图
    if (self.rootViewController.presentedViewController) {
        [self.rootViewController dismissViewControllerAnimated:animated completion:nil];
    }
    
    // 单导航栈
    if ([self.rootViewController isKindOfClass:UINavigationController.class]) {
        [(UINavigationController *)self.rootViewController popViewControllerAnimated:animated];
    }
    
    // 多导航栈：回到当前Tab的首页
    else if ([self.rootViewController isKindOfClass:UITabBarController.class]) {
        if ([[(UITabBarController *)self.rootViewController selectedViewController] isKindOfClass:UINavigationController.class] &&
            [(UINavigationController *)[(UITabBarController *)self.rootViewController selectedViewController] viewControllers].count>1) {
            [(UINavigationController *)[(UITabBarController *)self.rootViewController selectedViewController] popToRootViewControllerAnimated:animated];
        }
    }
    
    // 其他
    else {
        return NO;
    }
    
    return YES;
}

+ (BOOL)amk_gotoRootViewControllerAnimated:(BOOL)animated {
    return [UIApplication.sharedApplication.keyWindow amk_gotoRootViewControllerAnimated:animated];
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
