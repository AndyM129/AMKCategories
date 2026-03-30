//
//  UIImageView+AMKUIImageViewExtensionMethods.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2026/3/30.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AMKUIImageViewExtensionMethods)

/// 基于当前的 `contentMode`，获取 `image` 实际显示的 `rect`（相对于 `imageView.bounds`）
@property (nonatomic, assign, readonly) CGRect amk_imageRect;

/// 基于当前的 `contentMode`，将当前 `UIImageView` 坐标系下的 `viewRect` 转换为 `image` 坐标系
- (CGRect)amk_convertRectToImageCoordinate:(CGRect)viewRect;

@end
