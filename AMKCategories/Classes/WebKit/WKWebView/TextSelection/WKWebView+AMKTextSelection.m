//
//  WKWebView+AMKTextSelection.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2023/7/24.
//

#import "WKWebView+AMKTextSelection.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>
#import <AMKCategories/UIResponder+AMKUIResponderStandardEditActions.h>

@implementation WKWebView (AMKTextSelection)

- (AMKWKWebViewTextSelectionViewLayoutSubviewsBlock)amk_textSelectionViewLayoutSubviewsBlock {
    return objc_getAssociatedObject(self, @selector(amk_textSelectionViewLayoutSubviewsBlock));
}

- (void)setAmk_textSelectionViewLayoutSubviewsBlock:(AMKWKWebViewTextSelectionViewLayoutSubviewsBlock)amk_textSelectionViewLayoutSubviewsBlock {
    objc_setAssociatedObject(self, @selector(amk_textSelectionViewLayoutSubviewsBlock), amk_textSelectionViewLayoutSubviewsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

#pragma mark -

@implementation UIView (AMKTextSelection)

+ (void)load {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // iOS 11+
        [NSClassFromString(@"UITextSelectionView") amk_swizzleInstanceMethod:@selector(layoutSubviews) withMethod:@selector(AMKTextSelection_UITextSelectionView_layoutSubviews)];
        
        // iOS 17+
        [NSClassFromString(@"_UITextSelectionHighlightView") amk_swizzleInstanceMethod:@selector(layoutSubviews) withMethod:@selector(AMKTextSelection__UITextSelectionHighlightView_layoutSubviews)];
        [NSClassFromString(@"_UITextSelectionRangeAdjustmentContainerView") amk_swizzleInstanceMethod:@selector(layoutSubviews) withMethod:@selector(AMKTextSelection__UITextSelectionRangeAdjustmentContainerView_layoutSubviews)];
    });
}

#define AMKTextSelection_swizzleLayoutSubviewsForClass(className) \
- (void)AMKTextSelection_##className##_layoutSubviews { \
    [self AMKTextSelection_##className##_layoutSubviews]; \
    \
    WKWebView *webView = (id)[self amk_nextResponderWithClass:WKWebView.class]; \
    !webView.amk_textSelectionViewLayoutSubviewsBlock ?: webView.amk_textSelectionViewLayoutSubviewsBlock(webView, self); \
}

AMKTextSelection_swizzleLayoutSubviewsForClass(UITextSelectionView)
AMKTextSelection_swizzleLayoutSubviewsForClass(_UITextSelectionHighlightView)
AMKTextSelection_swizzleLayoutSubviewsForClass(_UITextSelectionRangeAdjustmentContainerView)

@end
