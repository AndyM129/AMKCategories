//
//  UIImageView+AMKUIImageViewExtensionMethods.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2026/3/30.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AMKUIImageViewExtensionMethods)

//@property (nonatomic, assign, readonly) CGRect amk_imageRect;

/// 将当前 `UIImageView` 坐标系下的 `rect` 转换为 `image` 坐标系
- (CGRect)amk_convertRectToImage:(CGRect)rect;

@end
