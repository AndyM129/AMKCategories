//
//  AMKColorSaturationBrightnessView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorSaturationBrightnessView.h"

@interface AMKColorSaturationBrightnessView ()

@end

@implementation AMKColorSaturationBrightnessView

#pragma mark - Init Methods

- (void)dealloc {
    [self removeObserverBlocks];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _hue = 0;
        _saturation = 1;
        _brightness = 1;
    }
    return self;
}

#pragma mark - Getters & Setters

- (void)setHue:(CGFloat)hue {
    _hue = MAX(0, MIN(hue, 1));
    [self setNeedsDisplay];
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextClipToRect(context, rect);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locs[2] = { 0.00f, 1.0f };
    
    // 色相渐变
    NSArray *colors = @[
        (id)[[UIColor colorWithHue:self.hue saturation:1 brightness:1 alpha:1.0] CGColor],
        (id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] CGColor],
    ];
    CGGradientRef grad = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locs);
    CGContextDrawLinearGradient(context, grad, CGPointMake(rect.size.width,0), CGPointMake(0, 0), 0);
    CGGradientRelease(grad);
    
    // 亮度渐变
    colors = @[
        (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
        (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] CGColor],
    ];
    grad = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locs);
    CGContextDrawLinearGradient(context, grad, CGPointMake(0, 0), CGPointMake(0, rect.size.height), 0);
    CGGradientRelease(grad);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
}

#pragma mark - Action Methods

- (void)handleTouches:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.width < FLT_EPSILON || self.height < FLT_EPSILON) {
        return;
    }
    
    CGPoint location = [touches.anyObject locationInView:self];
    location.x = MAX(0, MIN(location.x, self.width));
    location.y = MAX(0, MIN(location.y, self.height));
    
    self.saturation = location.x / self.width;
    self.brightness = 1 - location.y / self.height;
    //NSLog(@"location:{%.2f, %.2f} => saturation:%.2f, brightness:%.2f", location.x, location.y, self.saturation, self.brightness);
    !self.touchedBlock ?: self.touchedBlock(self, location);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
