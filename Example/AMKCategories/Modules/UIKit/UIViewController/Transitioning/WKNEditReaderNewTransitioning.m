//
//  WKNEditReaderNewTransitioning.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/1.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "WKNEditReaderNewTransitioning.h"

@implementation WKNEditReaderNewTransitioning

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithOperation:(UINavigationControllerOperation)operation {
    if (self = [super init]) {
        self.operation = operation;
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.operation == UINavigationControllerOperationPush) {
        UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [transitionContext.containerView addSubview:toViewController.view];
        
        // 遮罩
        UIView *dampingView = [UIView.alloc initWithFrame:transitionContext.containerView.bounds];
        dampingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [transitionContext.containerView insertSubview:dampingView belowSubview:toViewController.view];
        
        // 具体动画
        dampingView.alpha = 0;
        toViewController.view.transform = CGAffineTransformMakeTranslation(toViewController.view.frame.origin.x - toViewController.view.frame.size.width, 0);
        [UIView animateWithDuration:[self transitionDuration:nil] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            dampingView.alpha = 1;
            toViewController.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [dampingView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    } else if (self.operation == UINavigationControllerOperationPop) {
        UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [transitionContext.containerView insertSubview:toViewController.view atIndex:0];
        
        // 遮罩
        UIView *dampingView = [UIView.alloc initWithFrame:transitionContext.containerView.bounds];
        dampingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [transitionContext.containerView insertSubview:dampingView aboveSubview:toViewController.view];
        
        // 具体动画
        transitionContext.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [UIView animateWithDuration:[self transitionDuration:nil] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            dampingView.alpha = 0;
            fromViewController.view.transform = CGAffineTransformMakeTranslation(fromViewController.view.frame.origin.x - fromViewController.view.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [dampingView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}

#pragma mark - Helper Methods

@end
