//
//  AMK10090ExampleTableView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMK10090ExampleTableView.h"
#import <AMKCategories/UIResponder+AMKUIResponderExtensionMethods.h>
#import <WebKit/WebKit.h>

@implementation AMK10090ExampleTableView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.bounces = NO;
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"当前 tableView contentOffset：%@", @(self.contentOffset));
    
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"原本响应交互的视图：%@", view);
    
    WKWebView *webView = [view amk_nextResponderWithClass:WKWebView.class];
    if (webView) {
        NSLog(@"该视图所在 webView：%@", webView);
        
        CGRect webViewRectInTableView = [webView convertRect:webView.bounds toView:self];
        NSLog(@"该 webView 在 tableView 中的 Rect：%@", @(webViewRectInTableView));
        
        if (webViewRectInTableView.origin.y > self.contentOffset.y) {
            NSLog(@"已交由 tableView 响应交互");
            view = self;
        } else {
            NSLog(@"已保留 webView 的子视图响应交互");
        }
    }
    NSLog(@"最终响应UI为：%@\n\n", view);
    return view;
}

@end
