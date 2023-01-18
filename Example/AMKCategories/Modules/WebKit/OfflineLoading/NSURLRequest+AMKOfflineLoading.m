//
//  NSURLRequest+AMKOfflineLoading.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/10/31.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "NSURLRequest+AMKOfflineLoading.h"

@implementation NSURLRequest (AMKOfflineLoading)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

+ (NSString *)amk_directoryPathOfOfflineLoading {
    static NSString *directoryPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        directoryPath = [directoryPath stringByAppendingPathComponent:@"OfflineLoading"];
        
        if (![NSFileManager.defaultManager fileExistsAtPath:directoryPath]) {
            [NSFileManager.defaultManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    });
    return directoryPath;
}

/// 离线加载的文件路径
- (NSString *)amk_filePathOfOfflineLoading {
    // 拦截所有图片，转为加载本地资源
    // 示例：Accept = "image/webp,image/avif,video/*;q=0.8,image/png,image/svg+xml,image/*;q=0.8,*/*;q=0.5",
    if ([[self valueForHTTPHeaderField:@"Accept"].lowercaseString hasPrefix:@"image/"]) {
        return [NSString stringWithFormat:@"%@/%@", NSURLRequest.amk_directoryPathOfOfflineLoading, @"image.png"];
    }
    return nil;
}

/// 是否存在「已离线加载的文件」
- (BOOL)amk_fileExistsAtPathOfOfflineLoading {
    NSString *filePath = self.amk_filePathOfOfflineLoading;
    return filePath.length && [NSFileManager.defaultManager fileExistsAtPath:filePath];
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
