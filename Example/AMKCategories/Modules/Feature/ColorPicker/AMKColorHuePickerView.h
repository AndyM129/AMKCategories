//
//  AMKColorHuePickerView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorHueView.h"

@class AMKColorHuePickerView;
typedef void(^AMKColorHuePickerViewBlock)(AMKColorHuePickerView *_Nonnull colorHuePickerView);

/// 色相选择器
@interface AMKColorHuePickerView : UIControl

/// 色相视图
@property (nonatomic, strong, readonly, nullable) AMKColorHueView *hueView;

/// 滑块
@property (nonatomic, strong, readonly, nullable) UIView *thumbView;

/// 当前选中的色相，默认 `0`
///
/// 赋值时，会更新 `selectedColor`
@property (nonatomic, assign, readwrite) CGFloat selectedHue;

/// 当前选中的颜色
///
/// 赋值时，会更新 `selectedHue`
@property (nonatomic, strong, readwrite, nonnull) UIColor *selectedColor;

@end

#pragma mark -

/// UI样式相关
@interface AMKColorHuePickerView (AMKAppearance)

/// `colorHueView` 的默认高度
@property (nonatomic, assign, readonly, class) CGFloat hueViewDefaultHeight;

/// `thumbView` 的默认宽高
@property (nonatomic, assign, readonly, class) CGFloat thumbViewDefaultSize;

@end
