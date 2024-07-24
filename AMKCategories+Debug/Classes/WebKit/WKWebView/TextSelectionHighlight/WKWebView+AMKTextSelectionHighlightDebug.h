//
//  WKWebView+AMKTextSelectionHighlightDebug.h
//  AMKCategories+Debug
//
//  Created by Meng Xinxin on 2024/7/24.
//

#import <WebKit/WebKit.h>

/// WKWebView(AMKTextSelectionHighlight) 调试相关
@interface WKWebView (AMKTextSelectionHighlightDebug)

/// WKWebView(AMKTextSelectionHighlight) 调试开关：默认 NO
@property (nonatomic, assign, readwrite, class) BOOL amk_textSelectionHighlightDebugEnable;

@end
