//
//  NSObject+AMKERuntimeInfo.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/12/8.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "NSObject+AMKERuntimeInfo.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define AMKERuntimeInfoLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@implementation NSObject (AMKERuntimeInfo)

+ (void)amke_runtimeInfo {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count); // 拷贝出所胡的成员变量列表
    for (int i = 0; i<count; i++) {
        Ivar ivar = *(ivars + i); // 取出成员变量
        NSLog(@"%s -> %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar)); // 打印成员变量信息
    }
    free(ivars); // 释放
    
    AMKERuntimeInfoLog(@"=========================================================");
    
    unsigned int methCount = 0;
    Method *meths = class_copyMethodList([self class], &methCount);
    for(int i = 0; i < methCount; i++) {
        Method meth = meths[i];
        SEL sel = method_getName(meth);
        const char *name = sel_getName(sel);
        NSLog(@"%s", name);
    }
    free(meths);
}

- (void)amke_runtimeInfo {
    return [self amke_runtimeInfoForKeyPath:nil];
}

- (void)amke_runtimeInfoForKeyPath:(NSString *)keyPath {
    id object = keyPath.length ? [self valueForKeyPath:keyPath] : self;
    AMKERuntimeInfoLog(@"========================【 %@ %@ %@） 】=================================", keyPath.length?keyPath:@"", keyPath.length?@":":@"", [NSString stringWithFormat:@"<%@ %p>", NSStringFromClass([object class]), object]);
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([object class], &count); // 拷贝出所胡的成员变量列表
    for (int i = 0; i<count; i++) {
        Ivar ivar = *(ivars + i); // 取出成员变量
        NSString *name = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        id value = [type hasPrefix:@"{?="] ? type : [object valueForKey:name];
        AMKERuntimeInfoLog(@"%@ = %@", name, value); // 打印成员变量信息
    }
    free(ivars); // 释放
    
    AMKERuntimeInfoLog(@"----------------------------------------------------------------");
    unsigned int methCount = 0;
    Method *meths = class_copyMethodList([self class], &methCount);
    for(int i = 0; i < methCount; i++) {
        Method meth = meths[i];
        SEL sel = method_getName(meth);
        NSString *name = NSStringFromSelector(sel);
        AMKERuntimeInfoLog(@"%@", name);
    }
    free(meths);
    
    AMKERuntimeInfoLog(@"\n\n");
}

- (id)valueForUndefinedKey:(NSString *)key {
    return @"未获取到";
}

@end
