//
//  UIView+AMKViewLevel.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/3/9.
//

#import "UIView+AMKViewLevel.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

const AMKViewLevel AMKViewLevelDefault = 0.f;
const AMKViewLevel AMKViewLevelLow = 1000.f;
const AMKViewLevel AMKViewLevelLowHigher = 2500.f;
const AMKViewLevel AMKViewLevelMiddle = 5000.f;
const AMKViewLevel AMKViewLevelMiddleHigher = 7500.f;
const AMKViewLevel AMKViewLevelHigh = 10000.f;

@implementation UIView (AMKViewLevel)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        void (^__method_swizzling)(SEL, SEL) = ^(SEL sel, SEL _sel) {
            Method method = class_getInstanceMethod(self, sel);
            Method _method = class_getInstanceMethod(self, _sel);
            if (class_addMethod(self, sel, method_getImplementation(_method), method_getTypeEncoding(_method))) {
                class_replaceMethod(self, _sel, method_getImplementation(method), method_getTypeEncoding(method));
            } else {
                method_exchangeImplementations(method, _method);
            }
        };
        __method_swizzling(@selector(layoutSubviews), @selector(UIView_AMKViewLevel_layoutSubviews));
    });
}

- (AMKViewLevel)amk_viewLevel {
    NSNumber *viewLevel = objc_getAssociatedObject(self, @selector(amk_viewLevel));
    return [viewLevel integerValue];
}

- (void)setAmk_viewLevel:(AMKViewLevel)amk_viewLevel {
    objc_setAssociatedObject(self, @selector(amk_viewLevel), [NSNumber numberWithFloat:amk_viewLevel], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)UIView_AMKViewLevel_layoutSubviews {
    [self UIView_AMKViewLevel_layoutSubviews];
    
    NSArray *subviews = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
        if (view1.amk_viewLevel < view2.amk_viewLevel) return NSOrderedAscending;
        if (view1.amk_viewLevel > view2.amk_viewLevel) return NSOrderedDescending;
        return NSOrderedSame;
    }];
    [subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if (subview.amk_viewLevel > 0) {
            [self bringSubviewToFront:subview];
        }
    }];
}

@end
