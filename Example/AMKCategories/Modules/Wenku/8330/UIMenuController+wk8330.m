//
//  UIMenuController+wk8330.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/12/27.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "UIMenuController+wk8330.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@interface UIMenuController (_wk8330)

@end

@implementation UIMenuController (wk8330)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIMenuController amk_swizzleInstanceMethod:@selector(setMenuVisible:) withMethod:@selector(wk8330_setMenuVisible:)];
        [UIMenuController amk_swizzleInstanceMethod:@selector(setMenuVisible:animated:) withMethod:@selector(wk8330_setMenuVisible:animated:)];
        [UIMenuController amk_swizzleInstanceMethod:@selector(setTargetRect:inView:) withMethod:@selector(wk8330_setTargetRect:inView:)];
        [UIMenuController amk_swizzleInstanceMethod:@selector(showMenuFromView:rect:) withMethod:@selector(wk8330_showMenuFromView:rect:)];
        [UIMenuController amk_swizzleInstanceMethod:@selector(hideMenuFromView:) withMethod:@selector(wk8330_hideMenuFromView:)];
        [UIMenuController amk_swizzleInstanceMethod:@selector(hideMenu) withMethod:@selector(wk8330_hideMenu)];
    });
}

#pragma mark - Init Methods

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Public Methods

- (void)wk8330_setMenuVisible:(BOOL)menuVisible {
    [self wk8330_setMenuVisible:menuVisible];
    NSLog(@"%@", @{@"menuVisible": @(menuVisible)}.jsonStringEncoded);
}

- (void)wk8330_setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated {
    [self wk8330_setMenuVisible:menuVisible animated:animated];
    NSLog(@"%@", @{@"menuVisible": @(menuVisible), @"animated": @(animated)}.jsonStringEncoded);
}

- (void)wk8330_setTargetRect:(CGRect)targetRect inView:(UIView *)targetView {
    [self wk8330_setTargetRect:targetRect inView:targetView];
    NSLog(@"%@", @{@"targetRect": @(targetRect), @"targetView": targetView ?: @""}.jsonStringEncoded);
}

- (void)wk8330_showMenuFromView:(UIView *)targetView rect:(CGRect)targetRect {
    [self wk8330_showMenuFromView:targetView rect:targetRect];
    NSLog(@"%@", @{@"targetRect": @(targetRect), @"targetView": targetView ?: @""}.jsonStringEncoded);
}

- (void)wk8330_hideMenuFromView:(UIView *)targetView {
    [self wk8330_hideMenuFromView:targetView];
    NSLog(@"%@", @{@"targetView": targetView ?: @""}.jsonStringEncoded);
}

- (void)wk8330_hideMenu {
    [self wk8330_hideMenu];
    NSLog(@"%@", @{}.jsonStringEncoded);
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
