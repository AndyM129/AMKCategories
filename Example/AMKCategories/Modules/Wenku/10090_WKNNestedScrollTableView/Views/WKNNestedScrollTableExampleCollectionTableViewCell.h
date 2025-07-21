//
//  WKNNestedScrollTableExampleCollectionTableViewCell.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKNNestedScrollTableViewCell.h"
#import "WKNNestedScrollTableViewCachedCellProtocol.h"

/// WKNNestedScrollTableView 示例：WKNNestedScrollTableViewCell 的子类，支持显示 WKWebView
@interface WKNNestedScrollTableExampleCollectionTableViewCell : WKNNestedScrollTableViewCell <WKNNestedScrollTableViewCachedCellProtocol>

@property (nonatomic, strong, readonly, nullable) UICollectionView *collectionView;

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params;

@end
