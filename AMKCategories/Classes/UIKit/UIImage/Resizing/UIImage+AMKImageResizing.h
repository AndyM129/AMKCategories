//
//  UIImage+AMKImageResizing.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/3/9.
//

#import <UIKit/UIKit.h>

/// UIIMage 尺寸调整相关
@interface UIImage (AMKImageResizing)

/// 返回当前图片的 EdgeInsetsCenter
- (UIEdgeInsets)amk_capInsetsCenter;

/// 返回当前图片以 EdgeInsetsCenter 为 CapInsets 的可拉伸图片
- (UIImage *)amk_resizableImageWithCapInsetsCenter;

/// 返回指定名称的，以 EdgeInsetsCenter 为 CapInsets 的可拉伸图片
+ (UIImage *)amk_resizableImageWithCapInsetsCenterNamed:(NSString *)name;

@end
