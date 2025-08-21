//
//  AMKColorHueView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorHueView.h"

@interface AMKColorHueView ()

@end

@implementation AMKColorHueView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)drawRect:(CGRect)rect {
    // 色相渐变
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    float step = 0.166666666666667f;
    CGFloat locs[7] = {
        0.00f,
        step,
        step*2,
        step*3,
        step*4,
        step*5,
        1.0f,
    };
    NSArray *colors = @[
        (id)[[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] CGColor],
        (id)[[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0] CGColor],
        (id)[[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0] CGColor],
        (id)[[UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0] CGColor],
        (id)[[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] CGColor],
        (id)[[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0] CGColor],
        (id)[[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] CGColor],
    ];
    
    CGGradientRef grad = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locs);
    CGContextDrawLinearGradient(context, grad, CGPointMake(rect.size.width,0), CGPointMake(0, 0), 0);
    
    CGGradientRelease(grad);
    CGColorSpaceRelease(colorSpace);
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
