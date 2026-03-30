//
//  UIGeometry+AMKUIGeometryExtensionMethods.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2026/3/30.
//

#import "UIGeometry+AMKUIGeometryExtensionMethods.h"

CGRect AMKCGRectEdgeInsets(CGRect rect, UIEdgeInsets edgeInsets) {
    CGFloat x = rect.origin.x + edgeInsets.left;
    CGFloat y = rect.origin.y + edgeInsets.top;
    CGFloat width = MAX(0, rect.size.width - edgeInsets.left - edgeInsets.right);
    CGFloat height = MAX(0, rect.size.height - edgeInsets.top - edgeInsets.bottom);
    return CGRectMake(x, y, width, height);
}
