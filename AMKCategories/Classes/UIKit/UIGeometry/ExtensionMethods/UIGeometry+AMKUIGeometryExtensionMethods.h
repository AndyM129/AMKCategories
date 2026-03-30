//
//  UIGeometry+AMKUIGeometryExtensionMethods.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2026/3/30.
//

#import <UIKit/UIKit.h>

/// 对指定 `rect` 按 `edgeInsets` 进行内缩处理，并保证结果尺寸非负
CG_EXTERN CGRect AMKCGRectEdgeInsets(CGRect rect, UIEdgeInsets edgeInsets) __attribute__ ((warn_unused_result)) API_AVAILABLE(macos(10.0), ios(2.0));
