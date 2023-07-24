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
        [NSClassFromString(@"UITextSelectionView") amk_swizzleInstanceMethod:@selector(layoutSubviews) withMethod:@selector(AMKTextSelection_WKWebView_layoutSubviews)];
    });
}

- (void)AMKTextSelection_WKWebView_layoutSubviews {
    [self AMKTextSelection_WKWebView_layoutSubviews];
    
    WKWebView *webView = (id)[self amk_nextResponderWithClass:WKWebView.class];
    !webView.amk_textSelectionViewLayoutSubviewsBlock ?: webView.amk_textSelectionViewLayoutSubviewsBlock(webView, self);
}

@end
