//
//  AMKColorPickerView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

static const float AMKColorPickerViewDefaultHue = 0;
static const float AMKColorPickerViewDefaultSaturation = 1;
static const float AMKColorPickerViewDefaultBrightness = 1;

/// 取色
@interface AMKColorPickerView : UIView

/// 色相，默认为 `AMKColorPickerViewDefaultHue`
@property (assign, nonatomic) float hue;

/// 颜色饱和度，默认为 `AMKColorPickerViewDefaultSaturation`
@property (assign, nonatomic) float saturation;

/// 颜色亮度，默认为 `AMKColorPickerViewDefaultBrightness`
@property (assign, nonatomic) float brightness;

/// 颜色
@property (assign, nonatomic) UIColor *color;

@end
