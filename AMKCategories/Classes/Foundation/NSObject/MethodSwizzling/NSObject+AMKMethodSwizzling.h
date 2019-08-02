//
//  NSObject+AMKMethodSwizzling.h
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/8/3.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AMKMethodSwizzling)

/// 交换实例方法
+ (BOOL)amk_swizzleInstanceMethod:(SEL)originalSelector withMethod:(SEL)newSelector;

/// 交换类方法
+ (BOOL)amk_swizzleClassMethod:(SEL)originalSelector withMethod:(SEL)newSelector;

@end

NS_ASSUME_NONNULL_END
