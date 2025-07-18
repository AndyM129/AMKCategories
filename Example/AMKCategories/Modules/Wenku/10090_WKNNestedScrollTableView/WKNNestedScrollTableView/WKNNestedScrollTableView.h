//
//  WKNNestedScrollTableView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef __kindof UITableViewCell WKNNestedScrollTableViewCachedCell;

/// 支持嵌套 UIScrollView，并支持滚动事件传递、惯性联动的自定义 TableView
@interface WKNNestedScrollTableView : UITableView

/// 已缓存的 Cell
@property (nonatomic, strong, readonly, nullable) NSMutableDictionary<id, WKNNestedScrollTableViewCachedCell *> *cachedCells;

/// 从写父类方法，以添加对 `WKNNestedScrollTableViewCachedCellProtocol` 协议的支持
///
/// 对于遵守 `WKNNestedScrollTableViewCachedCellProtocol` 协议的 Cell 类，会优先从 `cachedCells` 中获取；若不存在，则会先创建，再添加到缓存，最后将其返回
- (nonnull __kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(nullable NSString *)identifier forIndexPath:(nullable NSIndexPath *)indexPath;

/// 处理嵌套的 UIScrollView 及滚动传递、惯性联动
- (void)preferredProcessNestedScrollTableViewDidScroll:(nullable __kindof UIScrollView *)scrollView;

@end
