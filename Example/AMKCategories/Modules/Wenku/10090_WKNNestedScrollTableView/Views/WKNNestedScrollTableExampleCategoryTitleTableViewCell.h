//
//  WKNNestedScrollTableExampleCategoryTitleTableViewCell.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryView.h>
#import "WKNNestedScrollTableViewCachedCellProtocol.h"
@class WKNNestedScrollTableExampleCategoryTitleTableViewCell;

typedef void(^WKNNestedScrollTableExampleCategoryTitleTableViewCellCategoryTitleViewDidSelectItemBlock)(WKNNestedScrollTableExampleCategoryTitleTableViewCell *_Nullable cell, NSInteger index);

/// WKNNestedScrollTableView 示例：支持显示 Tab 切换
@interface WKNNestedScrollTableExampleCategoryTitleTableViewCell : UITableViewCell <WKNNestedScrollTableViewCachedCellProtocol>

@property (nonatomic, strong, readonly, nullable) JXCategoryTitleView *categoryTitleView;

@property (nonatomic, copy, readwrite, nullable) WKNNestedScrollTableExampleCategoryTitleTableViewCellCategoryTitleViewDidSelectItemBlock categoryTitleViewDidSelectItemBlock;

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params;

@end
