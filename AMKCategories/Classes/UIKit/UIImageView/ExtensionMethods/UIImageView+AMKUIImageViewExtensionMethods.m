//
//  UIImageView+AMKUIImageViewExtensionMethods.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2026/3/30.
//

#import "UIImageView+AMKUIImageViewExtensionMethods.h"

@implementation UIImageView (AMKUIImageViewExtensionMethods)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

- (CGRect)amk_imageRect {
    // 若当前图像无有效size，则直接返回 CGRectZero
    CGSize imageSize = !self.image ? CGSizeZero : self.image.size;
    if (imageSize.width < FLT_EPSILON || imageSize.height < FLT_EPSILON) {
        return CGRectZero;
    }
    
    // 若当前视图无有效size，则直接返回 CGRectZero
    CGSize viewSize = self.bounds.size;
    if (viewSize.width < FLT_EPSILON || viewSize.height < FLT_EPSILON) {
        return CGRectZero;
    }
    
    // 分情况计算
    if (self.contentMode == UIViewContentModeScaleAspectFit) {
        // 计算缩放比例
        CGFloat scaleW = viewSize.width / imageSize.width;
        CGFloat scaleH = viewSize.height / imageSize.height;
        CGFloat scale = MIN(scaleW, scaleH);
        
        // 计算显示尺寸
        CGFloat displayWidth = imageSize.width * scale;
        CGFloat displayHeight = imageSize.height * scale;
        
        // 居中
        CGFloat x = MAX(0, (viewSize.width - displayWidth) * 0.5);
        CGFloat y = MAX(0, (viewSize.height - displayHeight) * 0.5);
        
        return CGRectMake(x, y, displayWidth, displayHeight);
    }

    // 其他情况 fallback 为 bounds（避免调用方异常）
    NSAssert(NO, @"暂未支持对当前 contentMode(%ld) 的处理", (long)self.contentMode);
    return self.bounds;
}

#pragma mark - Data & Networking

#pragma mark - Public Methods

- (CGRect)amk_convertRectToImageCoordinate:(CGRect)viewRect {
    // 若当前图像无有效size，则直接返回 CGRectZero
    CGSize imageSize = !self.image ? CGSizeZero : self.image.size;
    if (imageSize.width < FLT_EPSILON || imageSize.height < FLT_EPSILON) {
        return CGRectZero;
    }
    
    // 若当前视图无有效size，则直接返回 CGRectZero
    CGSize viewSize = self.bounds.size;
    if (viewSize.width < FLT_EPSILON || viewSize.height < FLT_EPSILON) {
        return CGRectZero;
    }
    
    // 分情况计算
    if (self.contentMode == UIViewContentModeScaleAspectFit) {
        // 1. 计算 scale
        CGFloat scale = MIN(viewSize.width / imageSize.width, viewSize.height / imageSize.height);
        if (scale < FLT_EPSILON) {
            return CGRectZero;
        }
        
        // 2. 计算 image 实际显示区域
        CGSize displaySize = CGSizeMake(imageSize.width * scale, imageSize.height * scale);
        CGFloat offsetX = (viewSize.width - displaySize.width) * 0.5;
        CGFloat offsetY = (viewSize.height - displaySize.height) * 0.5;
        CGRect imageDisplayRect = CGRectMake(offsetX, offsetY, displaySize.width, displaySize.height);
        
        // 3. 求交集：转换 viewRect -> imageDisplayRect 内坐标
        CGRect intersectRect = CGRectIntersection(viewRect, imageDisplayRect);
        if (CGRectIsNull(intersectRect) || CGRectIsEmpty(intersectRect)) {
            return CGRectZero;
        }
        
        // 4. 转换坐标
        CGFloat x = (intersectRect.origin.x - offsetX) / scale;
        CGFloat y = (intersectRect.origin.y - offsetY) / scale;
        CGFloat w = intersectRect.size.width / scale;
        CGFloat h = intersectRect.size.height / scale;
        
        // ⚠️ 浮点修正（非常关键）
        CGFloat epsilon = 1.0 / scale; // 1px 对应到 image 空间的误差
        CGFloat maxW = imageSize.width;
        CGFloat maxH = imageSize.height;

        // 5. clamp 到 image 边界
        x = MAX(0, MIN(x, maxW));
        y = MAX(0, MIN(y, maxH));
        w = MAX(0, MIN(w, maxW - x));
        h = MAX(0, MIN(h, maxH - y));
        
        // 边界吸附（避免 199.999 这种）
        if (fabs((x + w) - maxW) < epsilon) {
            w = maxW - x;
        }
        if (fabs((y + h) - maxH) < epsilon) {
            h = maxH - y;
        }
        
        CGRect result = CGRectMake(x, y, w, h);
        if (fabs(result.origin.x) < epsilon) result.origin.x = 0;
        if (fabs(result.origin.y) < epsilon) result.origin.y = 0;
        return result;
    }
    
    // 其他情况 fallback 为 CGRectZero
    NSAssert(NO, @"暂未支持对当前 contentMode(%ld) 的处理", (long)self.contentMode);
    return CGRectZero;
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
