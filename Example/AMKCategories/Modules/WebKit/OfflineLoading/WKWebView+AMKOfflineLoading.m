//
//  WKWebView+AMKOfflineLoading.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/10/31.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "WKWebView+AMKOfflineLoading.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@implementation WKWebView (AMKOfflineLoading)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WKWebView amk_swizzleClassMethod:@selector(handlesURLScheme:) withMethod:@selector(AMKOfflineLoading_WKWebView_handlesURLScheme:)];
    });
}

#pragma mark - Init Methods

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

/// hook 以便拦截 WKWebView 的 http(s)
+ (BOOL)AMKOfflineLoading_WKWebView_handlesURLScheme:(NSString *)urlScheme {
    if ([urlScheme isEqualToString:@"http"] || [urlScheme isEqualToString:@"https"]) {
        return NO;
    }
    return [self AMKOfflineLoading_WKWebView_handlesURLScheme:urlScheme];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
