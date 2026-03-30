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
    NSAssert(self.image != nil, @"image 不能为空");
    
    CGSize imageSize = self.image.size;
    CGSize viewSize = self.bounds.size;
    if (imageSize.width < FLT_EPSILON || imageSize.height < FLT_EPSILON || viewSize.width < FLT_EPSILON || viewSize.height < FLT_EPSILON) {
        return CGRectZero;
    }
    
    // 1. 计算 scale
    CGFloat scale = MIN(viewSize.width / imageSize.width, viewSize.height / imageSize.height);

    // 2. 计算 image 实际显示区域
    CGSize displaySize = CGSizeMake(imageSize.width * scale, imageSize.height * scale);

    CGFloat offsetX = (viewSize.width - displaySize.width) * 0.5;
    CGFloat offsetY = (viewSize.height - displaySize.height) * 0.5;
    CGRect imageDisplayRect = CGRectMake(offsetX, offsetY, displaySize.width, displaySize.height);

    // 3. 转换 viewRect -> imageDisplayRect 内坐标
    CGRect intersectRect = CGRectIntersection(viewRect, imageDisplayRect);
    
    if (CGRectIsNull(intersectRect)) {
        return CGRectZero;
    }
    
    // ⚠️ 注意：必须减去 offset
    CGFloat x = (intersectRect.origin.x - imageDisplayRect.origin.x) / scale;
    CGFloat y = (intersectRect.origin.y - imageDisplayRect.origin.y) / scale;
    CGFloat w = intersectRect.size.width / scale;
    CGFloat h = intersectRect.size.height / scale;

    CGRect result = CGRectMake(x, y, w, h);

    // 4. 防止越界
    CGRect imageBounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
    result = CGRectIntersection(result, imageBounds);

    return result;
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
