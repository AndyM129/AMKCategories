//
//  WKNNestedScrollTableViewCachedCellProtocol.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

/// WKNNestedScrollTableView 缓存 Cell 协议：遵守该协议 即可自动在初始化后缓存
@protocol WKNNestedScrollTableViewCachedCellProtocol <NSObject>

@end

#pragma mark -
#pragma mark -

/// 支持 WKNNestedScrollTableView 缓存的 Cell 类
typedef __kindof UITableViewCell<WKNNestedScrollTableViewCachedCellProtocol> WKNNestedScrollTableViewCachedCell;

/// WKNNestedScrollTableView 已缓存 Cell 的 CacheKey
///
/// 即：`cell` 的 `reuseIdentifier`
typedef NSString WKNNestedScrollTableViewCacheKey;
