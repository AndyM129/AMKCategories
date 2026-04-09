//
//  UIView+AMKInteractions.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/9/28.
//

#import "UIView+AMKInteractions.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@implementation UIView (AMKInteractions)

#pragma mark - Init Methods

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIView amk_swizzleInstanceMethod:@selector(pointInside:withEvent:) withMethod:@selector(AMKInteractions_UIView_pointInside:withEvent:)];
    });
}

#pragma mark - Properties

- (UIEdgeInsets)amk_interactionEdgeInsets {
    return [objc_getAssociatedObject(self, @selector(amk_interactionEdgeInsets)) UIEdgeInsetsValue];
}

- (void)setAmk_interactionEdgeInsets:(UIEdgeInsets)amk_interactionEdgeInsets {
    objc_setAssociatedObject(self, @selector(amk_interactionEdgeInsets), [NSValue valueWithUIEdgeInsets:amk_interactionEdgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Actions

#pragma mark - Override

- (BOOL)AMKInteractions_UIView_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.amk_interactionEdgeInsets, UIEdgeInsetsZero)
        || self.hidden
        || ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled)) {
        return [self AMKInteractions_UIView_pointInside:point withEvent:event]; // original implementation
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.amk_interactionEdgeInsets);
    hitFrame.size.width = MAX(hitFrame.size.width, 0); // don't allow negative sizes
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

#pragma mark - Delegate

#pragma mark - Helper Methods

@end

#pragma mark -
#pragma mark -

#define AMKInteractionsDebugEnable YES

#if defined(AMKInteractionsDebugEnable)

@interface NSObject (AMKInteractionsDebug)
- (nullable id)getAssociatedValueForKey:(void *)key;
- (void)setAssociateValue:(nullable id)value withKey:(void *)key;
- (void)addObserverBlockForKeyPath:(NSString*)keyPath block:(void (^)(id _Nonnull obj, id _Nonnull oldVal, id _Nonnull newVal))block;
@end

@implementation UIView (AMKInteractionsDebug)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIView amk_swizzleInstanceMethod:@selector(setAmk_interactionEdgeInsets:) withMethod:@selector(AMKInteractionsDebug_UIView_setAmk_interactionEdgeInsets:)];
        [UIView amk_swizzleInstanceMethod:@selector(layoutSubviews) withMethod:@selector(AMKInteractionsDebug_UIView_layoutSubviews)];
    });
}

- (void)AMKInteractionsDebug_UIView_setAmk_interactionEdgeInsets:(UIEdgeInsets)amk_interactionEdgeInsets {
    [self AMKInteractionsDebug_UIView_setAmk_interactionEdgeInsets:amk_interactionEdgeInsets];
    
    if (UIEdgeInsetsEqualToEdgeInsets(amk_interactionEdgeInsets, UIEdgeInsetsZero)) {
        [self setAssociateValue:nil withKey:@"bde_interactionEdgeInsets.debugLayer"];
    } else {
        CALayer *debugLayer = [self getAssociatedValueForKey:@"bde_interactionEdgeInsets.debugLayer"];
        if (!debugLayer) {
            NSUInteger hash = self.hash;
            CGFloat hue = (hash % 256) / 256.0;
            CGFloat saturation = 0.5 + ((hash >> 8) % 128) / 256.0;
            CGFloat brightness = 0.7 + ((hash >> 16) % 128) / 256.0;
            UIColor *hashColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
            
            debugLayer = [CALayer layer];
            debugLayer.frame = UIEdgeInsetsInsetRect(self.bounds, self.amk_interactionEdgeInsets);
            debugLayer.borderWidth = 1 / UIScreen.mainScreen.scale;
            debugLayer.borderColor = hashColor.CGColor;
            debugLayer.backgroundColor = [hashColor colorWithAlphaComponent:0.3].CGColor;
            [self.layer insertSublayer:debugLayer atIndex:0];
            [self setAssociateValue:debugLayer withKey:@"bde_interactionEdgeInsets.debugLayer"];
            [self setNeedsLayout];
        }
    }
}

- (void)AMKInteractionsDebug_UIView_layoutSubviews {
    [self AMKInteractionsDebug_UIView_layoutSubviews];
    
    CALayer *debugLayer = [self getAssociatedValueForKey:@"bde_interactionEdgeInsets.debugLayer"];
    if (debugLayer) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        debugLayer.frame = UIEdgeInsetsInsetRect(self.bounds, self.amk_interactionEdgeInsets);
        [CATransaction commit];
    }
}

@end

#endif
