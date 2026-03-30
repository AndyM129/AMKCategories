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
    // 若当前视图无有效size，则直接返回 CGRectZero
    if (self.bounds.size.width <= FLT_EPSILON || self.bounds.size.height <= FLT_EPSILON) {
        return CGRectZero;
    }
    
    // 若当前图像无有效size，则直接返回 CGRectZero
    if (!self.image || self.image.size.width <= FLT_EPSILON || self.image.size.height <= FLT_EPSILON) {
        return CGRectZero;
    }
    
    // 分情况计算
    if (self.contentMode == UIViewContentModeScaleAspectFit) {
        CGRect imageRect = CGRectZero;
        imageRect.size = self.image.size;
        imageRect.origin.x = (CGRectGetWidth(self.bounds) - imageRect.size.width) / 2;
        imageRect.origin.y = (CGRectGetHeight(self.bounds) - imageRect.size.height) / 2;
        return imageRect;
    }
    
    // 其他为处理情况，则直接返回 CGRectZero
    NSAssert(NO, @"暂未支持对当前 contentMode(%ld) 的处理", self.contentMode);
    return CGRectZero;
}

#pragma mark - Data & Networking

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
