//
//  UIView+AMKCornerRadii.h
//  AFNetworking
//
//  Created by Meng Xinxin on 2025/8/21.
//

#import <UIKit/UIKit.h>

/// 表示4个角 圆角值的结构体
typedef struct __attribute__((objc_boxable)) NS_SWIFT_SENDABLE API_AVAILABLE(watchos(2.0)) AMKCornerRadii {
    CGFloat topLeft, topRight, bottomLeft, bottomRight;
} AMKCornerRadii;

/// 构建 AMKCornerRadii 结构体
NS_INLINE AMKCornerRadii AMKCornerRadiiMake(CGFloat topLeft, CGFloat topRight, CGFloat bottomLeft, CGFloat bottomRight) {
    AMKCornerRadii cornerRadii = {topLeft, topRight, bottomLeft, bottomRight};
    return cornerRadii;
}

/// 构建 AMKCornerRadii 结构体
NS_INLINE AMKCornerRadii AMKCornerRadiiMakeAll(CGFloat cornerRadius) {
    return AMKCornerRadiiMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius);
}

/// 对比两个 AMKCornerRadii 是否相等
NS_INLINE BOOL AMKCornerRadiiEqualToCornerRadii(AMKCornerRadii r1, AMKCornerRadii r2) {
    return fabs(r1.topLeft - r2.topLeft) < FLT_EPSILON &&
           fabs(r1.topRight - r2.topRight) < FLT_EPSILON &&
           fabs(r1.bottomLeft - r2.bottomLeft) < FLT_EPSILON &&
           fabs(r1.bottomRight - r2.bottomRight) < FLT_EPSILON;
}

/// 4个角都是0 的 AMKCornerRadii
UIKIT_EXTERN const AMKCornerRadii AMKCornerRadiiZero;

#pragma mark -

/// 提供分类方法，可以给view添加不同的圆角
@interface UIView (AMKCornerRadii)

/// 基于 self.layer.mask 给视图添加圆角，并支持分别指定4个角的圆角值
@property (nonatomic, assign, readwrite) AMKCornerRadii amk_cornerRadii;

@end
