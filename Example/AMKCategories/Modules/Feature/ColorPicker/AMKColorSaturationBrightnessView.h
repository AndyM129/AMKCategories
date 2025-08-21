//
//  AMKColorSaturationBrightnessView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMKColorSaturationBrightnessView;
typedef void(^AMKColorSaturationBrightnessViewTouchedBlock)(AMKColorSaturationBrightnessView *_Nonnull colorHuePickerView, CGPoint location);

/// 指定色相的 饱和度&亮度 视图
@interface AMKColorSaturationBrightnessView : UIView

/// 色相，默认为 `0`
@property (assign, nonatomic) CGFloat hue;

/// 当前的饱和度，默认为 `1`
@property (assign, nonatomic) CGFloat saturation;

/// 当前的亮度，默认为 `1`
@property (assign, nonatomic) CGFloat brightness;

/// 触摸时的回调
@property (nonatomic, copy, readwrite, nullable) AMKColorSaturationBrightnessViewTouchedBlock touchedBlock;

@end
