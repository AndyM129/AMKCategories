//
//  UIView+UITextSelectionView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/24.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "UIView+UITextSelectionView.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>
#import <WebKit/WebKit.h>

@implementation UIView (UITextSelectionView)

+ (void)load {
    Class UITextSelectionView = NSClassFromString(@"UITextSelectionView");
    [UITextSelectionView amk_swizzleInstanceMethod:@selector(layoutSubviews) withMethod:@selector(UITextSelectionView_UIView_layoutSubviews)];
}

- (void)UITextSelectionView_UIView_layoutSubviews {
    [self UITextSelectionView_UIView_layoutSubviews];
    
    WKWebView *webView = (id)[self amk_nextResponderWithClass:WKWebView.class];
    if (webView && (!self.layer.mask || [self.layer.mask isKindOfClass:CAShapeLayer.class])) {
        CGRect frame = self.bounds;
        frame.size.height = 250 + 10 * 2; // 见 wk8250_wkeditorhelper.html 中 #dialog #content 的高度
        frame.origin.y = self.bounds.size.height - frame.size.height - 10 - 50;
        
        CAShapeLayer *layerMask = self.layer.mask ?: [CAShapeLayer layer];
        layerMask.path = [UIBezierPath bezierPathWithRect:frame].CGPath;
        self.layer.mask = layerMask;
        self.layer.backgroundColor = [UIColor.yellowColor colorWithAlphaComponent:0.5].CGColor;
    }
}

@end

@implementation UIResponder (WKCategories)

- (UIResponder *)amk_nextResponderWithClass:(Class)Class {
    UIResponder *nextResponder = self;
    while (nextResponder && ![nextResponder isKindOfClass:Class]) {
        nextResponder = nextResponder.nextResponder;
    }
    return nextResponder;
}

@end
