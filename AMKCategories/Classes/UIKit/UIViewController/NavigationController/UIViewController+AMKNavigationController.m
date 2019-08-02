//
//  UIViewController+AMKNavigationController.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/8/3.
//

#import "UIViewController+AMKNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (AMKNavigationController)

#pragma mark - Init Methods

#pragma mark - Properties

+ (UIViewController *)amk_topViewController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        UIWindow *sharedApplicationDelegateWindow = (UIWindow *)[[UIApplication sharedApplication].delegate performSelector:@selector(window)];
        if (sharedApplicationDelegateWindow && [sharedApplicationDelegateWindow isKindOfClass:[UIWindow class]]) {
            window = sharedApplicationDelegateWindow;
        }
    }
    
    UIViewController *topViewController = window.rootViewController;
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

- (UIViewController *)amk_topViewController {
    return UIViewController.amk_topViewController;
}

+ (UIViewController *)amk_previousViewController {
    return self.class.amk_topViewController.amk_previousViewController;
}

- (UIViewController *)amk_previousViewController {
    UIViewController *previousViewController = nil;
    
    // 若有导航栈，则返回前一个VC
    if (self.navigationController) {
        NSInteger currentIndex = [self.navigationController.viewControllers indexOfObject:self];
        if (currentIndex != NSNotFound) {
            NSInteger previousViewControllerIndex = [self.navigationController.viewControllers indexOfObject:self] - 1;
            if (previousViewControllerIndex >= 0) {
                previousViewController = [self.navigationController.viewControllers objectAtIndex:previousViewControllerIndex];
            }
        }
    }
    
    // 否则尝试获取 presentingViewController
    if (!previousViewController && self.presentingViewController) {
        previousViewController = self.presentingViewController;
    }
    
    // 如果找到了前一个VC，尝试获取其显示的视图控制器
    if (previousViewController) {
        while (YES) {
            if ([previousViewController isKindOfClass:[UINavigationController class]]) {
                previousViewController = [(UINavigationController *)previousViewController topViewController];
            } else if ([previousViewController isKindOfClass:[UITabBarController class]]) {
                previousViewController = [(UITabBarController *)previousViewController selectedViewController];
            } else {
                break;
            }
        }
    }
    
    return previousViewController;
}

- (BOOL)amk_presentedWithNavigationController {
    return [objc_getAssociatedObject(self, @selector(amk_presentedWithNavigationController)) boolValue];
}

- (void)setBde_presentedWithNavigationController:(BOOL)amk_presentedWithNavigationController {
    objc_setAssociatedObject(self, @selector(amk_presentedWithNavigationController), @(amk_presentedWithNavigationController), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public Methods

+ (BOOL)amk_goBackAnimated:(BOOL)animated {
    return [self.amk_topViewController amk_goBackAnimated:animated];
}

- (BOOL)amk_goBackAnimated:(BOOL)animated {
    if (self.navigationController) {
        if (self.navigationController.childViewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:animated];
            return YES;
        } else if (self.navigationController.presentingViewController) {
            [self.navigationController dismissViewControllerAnimated:animated completion:NULL];
            return YES;
        }
    } else if (self.presentingViewController) {
        [self dismissViewControllerAnimated:animated completion:NULL];
        return YES;
    }
    return NO;
}

- (BOOL)amk_goBack {
    return [self amk_goBackAnimated:YES];
}

+ (BOOL)amk_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [self.amk_topViewController amk_pushViewController:viewController animated:animated];
}

- (BOOL)amk_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [self amk_gotoViewController:viewController transitionStyle:AMKViewControllerTransitionStylePush animated:animated];
}

+ (BOOL)amk_presentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [self.amk_topViewController amk_presentViewController:viewController animated:animated];
}

- (BOOL)amk_presentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [self amk_gotoViewController:viewController transitionStyle:AMKViewControllerTransitionStylePresent animated:animated];
}

+ (BOOL)amk_gotoViewController:(UIViewController *)viewController transitionStyle:(AMKViewControllerTransitionStyle)transitionStyle animated:(BOOL)animated {
    return [self.amk_topViewController amk_gotoViewController:viewController transitionStyle:transitionStyle animated:animated];
}

- (BOOL)amk_gotoViewController:(UIViewController *)viewController transitionStyle:(AMKViewControllerTransitionStyle)transitionStyle animated:(BOOL)animated {
    if (transitionStyle == AMKViewControllerTransitionStylePresent) {
        if (viewController.amk_presentedWithNavigationController) {
            viewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        if (!self.parentViewController) {
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
