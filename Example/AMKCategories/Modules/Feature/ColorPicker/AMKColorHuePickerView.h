//
//  AMKColorHuePickerView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMKColorHueView.h"

/// 色相选择器
@interface AMKColorHuePickerView : UIView

/// 色相视图
@property (nonatomic, strong, readonly, nullable) AMKColorHueView *colorHueView;

/// 滑块
@property (nonatomic, strong, readonly, nullable) UIView *thumbView;

/// 当前的色相
@property (nonatomic, assign, readwrite) CGFloat colorHue;

/// 当前的颜色
@property (nonatomic, strong, readwrite, nonnull) UIColor *color;

@end

#pragma mark -

/// UI样式相关
@interface AMKColorHuePickerView (CPAppearance)

/// `colorHueView` 的默认高度
@property (nonatomic, assign, readonly, class) CGFloat colorHueViewDefaultHeight;

/// `thumbView` 的默认宽高
@property (nonatomic, assign, readonly, class) CGFloat thumbViewDefaultSize;

@end
