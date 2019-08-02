//
//  NSObject+AMKMethodSwizzling.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/8/3.
//

#import "NSObject+AMKMethodSwizzling.h"

@implementation NSObject (AMKMethodSwizzling)

+ (BOOL)amk_swizzleInstanceMethod:(SEL)originalSelector withMethod:(SEL)newSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    NSAssert(originalMethod, @"%@ %@ 原方法不存在", NSStringFromClass(self), NSStringFromSelector(originalSelector));
    NSAssert(originalMethod, @"%@ %@ 新实现的方法不存在", NSStringFromClass(self), NSStringFromSelector(newSelector));
    if (!originalMethod || !newMethod) return NO;

    if (class_addMethod(self, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(self, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
    return YES;
}

+ (BOOL)amk_swizzleClassMethod:(SEL)originalSelector withMethod:(SEL)newSelector {
    Class class = object_getClass(self);
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method newMethod = class_getClassMethod(class, newSelector);
    NSAssert(originalMethod, @"%@ %@ 原方法不存在", NSStringFromClass(class), NSStringFromSelector(originalSelector));
    NSAssert(originalMethod, @"%@ %@ 新实现的方法不存在", NSStringFromClass(class), NSStringFromSelector(newSelector));
    if (!originalMethod || !newMethod) return NO;
    
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

@end
