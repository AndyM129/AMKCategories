//
//  NSDictionary+AMKProtocolProperties.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/9/5.
//

#import "NSDictionary+AMKProtocolProperties.h"
#import <objc/runtime.h>

@implementation NSDictionary (AMKProtocolProperties)

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    static NSString *kPrefix = @"amkpp_";
    NSString *selName = NSStringFromSelector(sel);
    if ([selName hasPrefix:kPrefix]) {
        // 动态生成 IMP
        IMP imp = imp_implementationWithBlock(^id(NSDictionary *selfDict){
            NSString *key = [selName substringFromIndex:kPrefix.length]; // 去掉前缀
            id value = [selfDict objectForKey:key];
            id result = value != NSNull.null ? value : nil;
            return result;
        });

        // 使用 "@@:" 表示返回对象，接收 id 和 SEL
        class_addMethod(self.class, sel, imp, "@@:");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

@end
