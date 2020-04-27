//
//  WKWebView+AMKScreenshot.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/4/27.
//

#import <WebKit/WebKit.h>

/// WKWebView 截图相关
@interface WKWebView (AMKScreenshot)

- (void)snaplongWebViewWithMaxHeight:(CGFloat)maxheigtht finsih:(void (^_Nullable)(UIImage *_Nullable image))finishBlock;

@end
