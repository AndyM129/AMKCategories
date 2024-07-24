//
//  WKWebView+AMKTextSelectionHighlight.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2024/7/24.
//

#import <WebKit/WebKit.h>

typedef void(^AMKWKWebViewTextSelectionViewLayoutSubviewsBlock)(WKWebView *_Nullable webView, UIView *_Nullable textSelectionView);

@interface WKWebView (AMKTextSelectionHighlight)

/// 选中文本 可显示高亮的 `frame`（相对于子视图 `scrollView` ）
@property (nonatomic, assign, readwrite) CGRect amk_textSelectionHighlightViewLayerMaskFrame;

@end
