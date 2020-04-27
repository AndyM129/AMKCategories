//
//  WKWebView+AMKScreenshot.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/4/27.
//

#import <WebKit/WebKit.h>

/// WKWebView 截图相关
@interface WKWebView (AMKScreenshot)

/// 实现一：
- (void)snaplongWebViewWithMaxHeight:(CGFloat)maxheigtht finsih:(void (^_Nullable)(UIImage *_Nullable image))finishBlock;

/// 实现二：
- (void)takeSnapshotInRect:(CGRect)rect completionHandler:(void (^_Nullable)(UIImage * _Nullable snapshotImage, NSError * _Nullable error))completionHandler;

@end



