//
//  UIImage+AMKImageRendering.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/11/18.
//

#import <UIKit/UIKit.h>

/// 图像渲染相关扩展
@interface UIImage (AMKImageRendering)

#pragma mark - Init Methods

/// 以指定颜色、大小、圆角 生成新图像，并返回
+ (UIImage *_Nullable)amk_imageWithColor:(UIColor *_Nullable)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

#pragma mark - Alpha

/// 以当前图像，生成指定透明度的新图像，并返回
- (UIImage *_Nullable)bde_imageWithAlpha:(CGFloat)alpha;

#pragma mark - Tint Color

/// 以当前图像渲染成指定颜色，并返回新图像
- (UIImage *_Nullable)bde_imageWithTintColor:(UIColor *_Nullable)tintColor;

/// 以当前图像 以指定混合模式，颜色进行处理，并返回新图像
- (UIImage *_Nullable)bde_imageWithTintColor:(UIColor *_Nullable)tintColor blendMode:(CGBlendMode)blendMode;

@end
