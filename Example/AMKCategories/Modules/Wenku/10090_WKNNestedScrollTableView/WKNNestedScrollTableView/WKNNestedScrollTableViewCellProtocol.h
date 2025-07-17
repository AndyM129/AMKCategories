//
//  WKNNestedScrollTableViewCellProtocol.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

/// WKNNestedScrollTableView 中，会嵌套滚动视图的 Cell 的协议：遵守该协议，以便在 WKNNestedScrollTableView 中进行相关处理
@protocol WKNNestedScrollTableViewCellProtocol <NSObject>

- (UIScrollView *)nestedScrollView;

@end
