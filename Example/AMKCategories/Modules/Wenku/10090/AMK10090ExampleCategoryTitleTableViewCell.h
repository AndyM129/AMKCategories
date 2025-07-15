//
//  AMK10090ExampleCategoryTitleTableViewCell.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/15.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryView.h>
@class AMK10090ExampleCategoryTitleTableViewCell;

typedef void(^AMK10090ExampleCategoryTitleTableViewCellCategoryTitleViewDidSelectItemBlock)(AMK10090ExampleCategoryTitleTableViewCell *_Nullable cell, NSInteger index);

/// Tab TableViewCell
@interface AMK10090ExampleCategoryTitleTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly, nullable) JXCategoryTitleView *categoryTitleView;

@property (nonatomic, copy, readwrite, nullable) AMK10090ExampleCategoryTitleTableViewCellCategoryTitleViewDidSelectItemBlock categoryTitleViewDidSelectItemBlock;

+ (CGFloat)tableView:(UITableView *_Nullable)tableView heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;

@end
