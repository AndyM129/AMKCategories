//
//  CGGeometry+AMKCGGeometryExtensionMethods.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2026/3/30.
//

#import "CGGeometry+AMKCGGeometryExtensionMethods.h"

CGRect AMKCGRectEdgeInsets(CGRect rect, UIEdgeInsets edgeInsets) {
    return CGRectMake((rect.origin.x + edgeInsets.left), (rect.origin.y + edgeInsets.top), (rect.size.width - edgeInsets.left - edgeInsets.right), (rect.size.height - edgeInsets.top - edgeInsets.bottom));
}
