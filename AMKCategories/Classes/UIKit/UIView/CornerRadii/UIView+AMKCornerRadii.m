//
//  UIView+AMKCornerRadii.m
//  AFNetworking
//
//  Created by Meng Xinxin on 2025/8/21.
//

#import "UIView+AMKCornerRadii.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>

const AMKCornerRadii AMKCornerRadiiZero = {0, 0, 0, 0};

@interface UIView ()

@end

@implementation UIView (AMKCornerRadii)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

- (AMKCornerRadii)amk_cornerRadii {
    NSValue *cornerRadiiValue = objc_getAssociatedObject(self, @selector(amk_cornerRadii));
    AMKCornerRadii _cornerRadii;
    [cornerRadiiValue getValue:&_cornerRadii];
    return _cornerRadii;
}

- (void)setAmk_cornerRadii:(AMKCornerRadii)cornerRadii {
    // 若值相同，则直接返回
    AMKCornerRadii _cornerRadii = self.amk_cornerRadii;
    if (AMKCornerRadiiEqualToCornerRadii(_cornerRadii, cornerRadii)) {
        return;
    }
    
    // 保存新值
    _cornerRadii = cornerRadii;
    NSValue *value = [NSValue valueWithBytes:&_cornerRadii objCType:@encode(AMKCornerRadii)];
    objc_setAssociatedObject(self, @selector(amk_cornerRadii), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 若值为 0，则移除 hook
    static void *kAspectTokenKey = &kAspectTokenKey;
    id<AspectToken> aspectToken = objc_getAssociatedObject(self, kAspectTokenKey);
    if (AMKCornerRadiiEqualToCornerRadii(_cornerRadii, AMKCornerRadiiZero)) {
        [aspectToken remove];
        self.layer.mask = nil;
    }
    // 否则，按需添加 hook，以便后续自动更新UI
    else if (!aspectToken){
        aspectToken = [self aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            [aspectInfo.instance amkCornerRadii_updateLayerMask];
        } error:nil];
        objc_setAssociatedObject(self, kAspectTokenKey, aspectToken, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // 或直接立即更新UI
    else {
        [self amkCornerRadii_updateLayerMask];
    }
}

#pragma mark - private

/// 更新圆角遮罩
- (void)amkCornerRadii_updateLayerMask {
    AMKCornerRadii _cornerRadii = self.amk_cornerRadii;
    
    // 创建自定义路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect bounds = self.bounds;
    
    // 起点：左上角中点
    [path moveToPoint:CGPointMake(_cornerRadii.topLeft, 0)];
    
    // 上边和右上角
    [path addLineToPoint:CGPointMake(CGRectGetWidth(bounds) - _cornerRadii.topRight, 0)];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(bounds) - _cornerRadii.topRight, _cornerRadii.topRight)
                    radius:_cornerRadii.topRight
                startAngle:-M_PI_2
                  endAngle:0
                 clockwise:YES];
    
    // 右边和右下角
    [path addLineToPoint:CGPointMake(CGRectGetWidth(bounds), CGRectGetHeight(bounds) - _cornerRadii.bottomRight)];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(bounds) - _cornerRadii.bottomRight, CGRectGetHeight(bounds) - _cornerRadii.bottomRight)
                    radius:_cornerRadii.bottomRight
                startAngle:0
                  endAngle:M_PI_2
                 clockwise:YES];
    
    // 下边和左下角
    [path addLineToPoint:CGPointMake(_cornerRadii.bottomLeft, CGRectGetHeight(bounds))];
    [path addArcWithCenter:CGPointMake(_cornerRadii.bottomLeft, CGRectGetHeight(bounds) - _cornerRadii.bottomLeft)
                    radius:_cornerRadii.bottomLeft
                startAngle:M_PI_2
                  endAngle:M_PI
                 clockwise:YES];
    
    // 左边和左上角
    [path addLineToPoint:CGPointMake(0, _cornerRadii.topLeft)];
    [path addArcWithCenter:CGPointMake(_cornerRadii.topLeft, _cornerRadii.topLeft)
                    radius:_cornerRadii.topLeft
                startAngle:M_PI
                  endAngle:-M_PI_2
                 clockwise:YES];
    
    [path closePath];
    
    // 创建遮罩层
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
