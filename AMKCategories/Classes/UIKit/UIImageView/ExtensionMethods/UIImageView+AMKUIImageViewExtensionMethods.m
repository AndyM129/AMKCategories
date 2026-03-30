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

//- (CGRect)amk_imageRect {
//    // 若当前视图无有效size，则直接返回 CGRectZero
//    if (self.bounds.size.width <= FLT_EPSILON || self.bounds.size.height <= FLT_EPSILON) {
//        return CGRectZero;
//    }
//    
//    // 若当前图像无有效size，则直接返回 CGRectZero
//    if (!self.image || self.image.size.width <= FLT_EPSILON || self.image.size.height <= FLT_EPSILON) {
//        return CGRectZero;
//    }
//    
//    // 分情况计算
//    if (self.contentMode == UIViewContentModeScaleAspectFit) {
//        CGRect imageRect = CGRectZero;
//        imageRect.size = self.image.size;
//        imageRect.origin.x = (CGRectGetWidth(self.bounds) - imageRect.size.width) / 2;
//        imageRect.origin.y = (CGRectGetHeight(self.bounds) - imageRect.size.height) / 2;
//        return imageRect;
//    }
//    
//    // 其他为处理情况，则直接返回 CGRectZero
//    NSAssert(NO, @"暂未支持对当前 contentMode(%ld) 的处理", self.contentMode);
//    return CGRectZero;
//}

#pragma mark - Data & Networking

#pragma mark - Public Methods

- (CGRect)amk_convertRectToImage:(CGRect)rect {
    NSAssert(self.image != nil, @"image 不能为空");
    
    CGSize imageSize = self.image.size;
    CGSize viewSize = self.bounds.size;
    if (imageSize.width <= 0 || imageSize.height <= 0 || viewSize.width <= 0 || viewSize.height <= 0) {
        return CGRectZero;
    }

    // 1. 计算 scale
    CGFloat scale = MIN(viewSize.width / imageSize.width, viewSize.height / imageSize.height);

    // 2. 计算 image 实际显示区域
    CGSize displaySize = CGSizeMake(imageSize.width * scale, imageSize.height * scale);

    CGFloat offsetX = (viewSize.width - displaySize.width) * 0.5;
    CGFloat offsetY = (viewSize.height - displaySize.height) * 0.5;
    CGRect imageDisplayRect = CGRectMake(offsetX, offsetY, displaySize.width, displaySize.height);

    // 3. 转换 rect -> imageDisplayRect 内坐标
    CGRect intersectRect = CGRectIntersection(rect, imageDisplayRect);

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
