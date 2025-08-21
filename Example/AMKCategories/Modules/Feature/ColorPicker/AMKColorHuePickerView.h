//
//  AMKColorHuePickerView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMKColorHueView.h"

@class AMKColorHuePickerView;
typedef void(^AMKColorHuePickerViewBlock)(AMKColorHuePickerView *_Nonnull colorHuePickerView);

/// 色相选择器
@interface AMKColorHuePickerView : UIView

/// 色相视图
@property (nonatomic, strong, readonly, nullable) AMKColorHueView *hueView;

/// 滑块
@property (nonatomic, strong, readonly, nullable) UIView *thumbView;

/// 当前的色相
@property (nonatomic, assign, readwrite) CGFloat hue;

/// 当前的颜色
@property (nonatomic, strong, readwrite, nonnull) UIColor *color;

/// 色相值变更时回调
@property (nonatomic, copy, readwrite, nullable) AMKColorHuePickerViewBlock hueChangedBlock;

@end

#pragma mark -

/// UI样式相关
@interface AMKColorHuePickerView (AMKAppearance)

/// `colorHueView` 的默认高度
@property (nonatomic, assign, readonly, class) CGFloat hueViewDefaultHeight;

/// `thumbView` 的默认宽高
@property (nonatomic, assign, readonly, class) CGFloat thumbViewDefaultSize;

@end
