////
////  UIView+UITextSelectionView.m
////  AMKCategories_Example
////
////  Created by Meng Xinxin on 2023/7/24.
////  Copyright © 2023 AndyM129. All rights reserved.
////
//
//#import "UIView+UITextSelectionView.h"
//#import <AMKCategories/NSObject+AMKMethodSwizzling.h>
//#import <WebKit/WebKit.h>
//
//@implementation WKWebView (UITextSelectionView)
//
//+ (void)load {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [NSClassFromString(@"UITextSelectionView") amk_swizzleInstanceMethod:@selector(layoutSubviews) withMethod:@selector(UITextSelectionView_UIView_layoutSubviews)];
//    });
//}
//
//#pragma mark - Getters & Setters
//
//- (AMKWKWebViewTextSelectionViewLayoutSubviewsBlock)amk_textSelectionViewLayoutSubviewsBlock {
//    return objc_getAssociatedObject(self, @selector(amk_textSelectionViewLayoutSubviewsBlock));
//}
//
//- (void)setAmk_textSelectionViewLayoutSubviewsBlock:(AMKWKWebViewTextSelectionViewLayoutSubviewsBlock)amk_textSelectionViewLayoutSubviewsBlock {
//    objc_setAssociatedObject(self, @selector(amk_textSelectionViewLayoutSubviewsBlock), amk_textSelectionViewLayoutSubviewsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//#pragma mark - Data & Networking
//
//#pragma mark - Layout Subviews
//
//- (void)UITextSelectionView_UIView_layoutSubviews {
//    [self UITextSelectionView_UIView_layoutSubviews];
//    !self.amk_textSelectionViewLayoutSubviewsBlock ?: self.amk_textSelectionViewLayoutSubviewsBlock(self);
//}
//
//#pragma mark - Action Methods
//
//#pragma mark - Notifications
//
//#pragma mark - KVO
//
//#pragma mark - Protocol
//
//#pragma mark - Helper Methods
//
//@end
