//
//  WKWebView+AMKScreenshot.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/4/27.
//

#import <WebKit/WebKit.h>

/// WKWebView 截图相关
@interface WKWebView (AMKScreenshot)

- (void)amk_takeSnapshotInRect:(CGRect)rect completionHandler:(void (^_Nullable)(UIImage * _Nullable snapshotImage, NSError * _Nullable error))completionHandler;

@end



