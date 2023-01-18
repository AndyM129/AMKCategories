//
//  NSURLRequest+AMKOfflineLoading.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/10/31.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import <Foundation/Foundation.h>

/// WKWebView 离线加载
@interface NSURLRequest (AMKOfflineLoading)

/// 离线加载的文件目录
+ (NSString *_Nullable)amk_directoryPathOfOfflineLoading;

/// 离线加载的文件路径
- (NSString *_Nullable)amk_filePathOfOfflineLoading;

/// 是否存在「已离线加载的文件」
- (BOOL)amk_fileExistsAtPathOfOfflineLoading;

@end
