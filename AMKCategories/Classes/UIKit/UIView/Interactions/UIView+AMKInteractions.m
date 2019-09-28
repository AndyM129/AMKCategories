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

