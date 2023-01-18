//
//  WKWebView+AMKOfflineLoading.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/10/31.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "NSURLRequest+AMKOfflineLoading.h"

#ifdef DEBUG
#define AMKWebViewOfflineLoadLog(fmt, ...) NSLog((@"AMKWebViewOfflineLoad " fmt), ##__VA_ARGS__)
#else
#define AMKWebViewOfflineLoadLog(...)
#endif

/// WKWebView 离线加载
@interface WKWebView (AMKOfflineLoading)

@end
