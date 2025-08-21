//
//  AMKColorPickerView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorPickerView.h"

@interface AMKColorPickerView ()
@property (nonatomic, strong, readwrite, nullable) CALayer *colorLayer;
@end

@implementation AMKColorPickerView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = UIColor.lightGrayColor.CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        
        self.hue = AMKColorPickerViewDefaultHue;
        self.saturation = AMKColorPickerViewDefaultSaturation;
        self.brightness = AMKColorPickerViewDefaultBrightness;
    }
    return self;
}

#pragma mark - Getters & Setters

- (CALayer *)colorLayer {
    if (!_colorLayer) {
        _colorLayer = [CALayer layer];
    }
    return _colorLayer;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    // Coding ...
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)drawRect:(CGRect)rect {
    // draw the photoshop gradient
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextClipToRect(context, rect);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat locs[2] = { 0.00f, 1.0f };
    
    NSArray *colors = @[
        (id)[[UIColor colorWithHue:self.hue saturation:1 brightness:1 alpha:1.0] CGColor],
        (id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] CGColor],
    ];
    
   
    
    CGGradientRef grad = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locs);
    CGContextDrawLinearGradient(context, grad, CGPointMake(rect.size.width,0), CGPointMake(0, 0), 0);
    CGGradientRelease(grad);
    
    colors=[NSArray arrayWithObjects:
            (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0] CGColor],
            (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] CGColor],
            nil];
    
    grad=CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locs);
    CGContextDrawLinearGradient(context, grad, CGPointMake(0, 0), CGPointMake(0, rect.size.height), 0);
    CGGradientRelease(grad);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
    
//    // draw the reticule
//    
//    CGPoint realPos=CGPointMake(self.saturation*rect.size.width, rect.size.height-(self.brightness*rect.size.height));
//    CGRect reticuleRect=CGRectMake(realPos.x-10, realPos.y-10, 20, 20);
//    
//    CGContextAddEllipseInRect(context, reticuleRect);
//    CGContextAddEllipseInRect(context, CGRectInset(reticuleRect, 4, 4));
//    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
//    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
//    CGContextSetLineWidth(context, 0.5);
//    CGContextClosePath(context);
//    CGContextSetShadow(context, CGSizeMake(1, 1), 4);
//    CGContextDrawPath(context, kCGPathEOFillStroke);
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
