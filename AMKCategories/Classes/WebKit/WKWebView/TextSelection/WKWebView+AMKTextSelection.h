//
//  WKWebView+AMKTextSelection.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2023/7/24.
//

#import <WebKit/WebKit.h>

typedef void(^AMKWKWebViewTextSelectionViewLayoutSubviewsBlock)(WKWebView *_Nullable webView, UIView *_Nullable textSelectionView);

@interface WKWebView (AMKTextSelection)

/// 子视图 `WKWebView > WKScrollView > UIView > UITextSelectionView` 执行 `-layoutSubviews` 方法时的回调
@property (nonatomic, copy, readwrite, nullable) AMKWKWebViewTextSelectionViewLayoutSubviewsBlock amk_textSelectionViewLayoutSubviewsBlock;

@end
