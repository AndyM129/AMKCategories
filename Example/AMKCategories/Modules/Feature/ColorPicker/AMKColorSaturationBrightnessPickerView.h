//
//  AMKColorSaturationBrightnessPickerView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorSaturationBrightnessView.h"

/// 指定色相的 饱和度&亮度 选择器
@interface AMKColorSaturationBrightnessPickerView : UIView

/// 指定色相的 饱和度&亮度 视图
@property (nonatomic, strong, readonly, nullable) AMKColorSaturationBrightnessView *saturationBrightnessView;

/// 颜色光标，其 center 对准 `saturationBrightnessView` 中所选定的位置
@property (nonatomic, strong, readonly, nullable) UIImageView *cursorView;

@end
