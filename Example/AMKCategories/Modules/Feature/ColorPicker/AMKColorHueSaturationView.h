//
//  AMKColorHueSaturationView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

static const float AMKColorHueSaturationViewDefaultHue = 0;
static const float AMKColorHueSaturationViewDefaultSaturation = 1;
static const float AMKColorHueSaturationViewDefaultBrightness = 1;

/// 色盘视图
@interface AMKColorHueSaturationView : UIView

/// 色相，默认为 `AMKColorHueSaturationViewDefaultHue`
@property (assign, nonatomic) float hue;

/// 颜色饱和度，默认为 `AMKColorHueSaturationViewDefaultSaturation`
@property (assign, nonatomic) float saturation;

/// 颜色亮度，默认为 `AMKColorHueSaturationViewDefaultBrightness`
@property (assign, nonatomic) float brightness;

/// 颜色
@property (assign, nonatomic) UIColor *color;

@end
