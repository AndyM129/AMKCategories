//
//  WKNNestedScrollTableViewCell.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/7/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

/// WKNNestedScrollTableView 中，有嵌套滚动视图的 Cell 的基类：以便在 WKNNestedScrollTableView 中进行相关处理
@interface WKNNestedScrollTableViewCell : UITableViewCell

/// 嵌套的滚动视图
- (nullable UIScrollView *)nestedScrollView;

/// 嵌套的滚动视图 在真正加载之前的默认高度
- (CGFloat)nestedScrollViewDefaultHeight;

@end
