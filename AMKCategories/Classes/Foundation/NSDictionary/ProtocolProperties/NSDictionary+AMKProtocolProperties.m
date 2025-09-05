//
//  NSDictionary+AMKProtocolProperties.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/9/5.
//

#import "NSDictionary+AMKProtocolProperties.h"
#import <objc/runtime.h>

@implementation NSDictionary (AMKProtocolProperties)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

//static NSString *amkProtocolProperties_keyFromSelector(SEL _cmd) {
//    NSString *selName = NSStringFromSelector(_cmd);
//    return [selName stringByReplacingOccurrencesOfString:@"amkpp_" withString:@""];
//}
//
//static id amkProtocolProperties_dynamicGetter_id_safe(id self, SEL _cmd) {
//    NSString *key = amkProtocolProperties_keyFromSelector(_cmd);
//    id value = [self objectForKey:key];
//
//    if (value == nil || value == [NSNull null]) {
//        return nil;
//    }
//
//    // 获取协议属性类型
//    objc_property_t property = class_getProperty([self class], sel_getName(_cmd));
//    if (!property) return value;
//
//    const char *typeEncoding = property_copyAttributeValue(property, "T");
//    if (!typeEncoding) return value;
//
//    id result = nil;
//
//    if (typeEncoding[0] == _C_ID) {
//        // 对象类型，解析类名
//        char *className = property_copyAttributeValue(property, "T");
//        if (className) {
//            NSString *clsName = [NSString stringWithUTF8String:className];
//            // 属性编码可能是 @"NSString"
//            if ([clsName hasPrefix:@"@\""] && clsName.length > 3) {
//                NSString *expectedClassName = [clsName substringWithRange:NSMakeRange(2, clsName.length - 3)];
//                Class expectedClass = NSClassFromString(expectedClassName);
//                if ([value isKindOfClass:expectedClass]) {
//                    result = value;
//                } else {
//                    result = nil; // 类型不匹配返回 nil
//                }
//            } else {
//                result = value;
//            }
//            free(className);
//        } else {
//            result = value;
//        }
//    } else {
//        // 非对象类型，返回 nil
//        result = nil;
//    }
//
//    free((void *)typeEncoding);
//    return result;
//}
//
//static NSInteger amkProtocolProperties_dynamicGetter_integer(id self, SEL _cmd) {
//    id value = [self objectForKey:amkProtocolProperties_keyFromSelector(_cmd)];
//    return [value respondsToSelector:@selector(integerValue)] ? [value integerValue] : 0;
//}
//
//static BOOL amkProtocolProperties_dynamicGetter_bool(id self, SEL _cmd) {
//    id value = [self objectForKey:amkProtocolProperties_keyFromSelector(_cmd)];
//    return [value respondsToSelector:@selector(boolValue)] ? [value boolValue] : NO;
//}
//
//static double amkProtocolProperties_dynamicGetter_double(id self, SEL _cmd) {
//    id value = [self objectForKey:amkProtocolProperties_keyFromSelector(_cmd)];
//    return [value respondsToSelector:@selector(doubleValue)] ? [value doubleValue] : 0.0;
//}

#pragma mark - Data & Networking

#pragma mark - Public Methods

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    struct objc_method_description methodDesc = protocol_getMethodDescription(@protocol(AMKProtocolProperties), sel, YES, YES);
//    if (methodDesc.name == NULL) {
//        return [super resolveInstanceMethod:sel];
//    }
//
//    const char *encoding = methodDesc.types;
//
//    switch (encoding[0]) {
//        case _C_ID:
//            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_id_safe, encoding);
//            break;
//        case _C_INT:
//        case _C_LNG_LNG:
//            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_integer, encoding);
//            break;
//        case _C_BOOL:
//            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_bool, encoding);
//            break;
//        case _C_DBL:
//        case _C_FLT:
//            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_double, encoding);
//            break;
//        default:
//            class_addMethod(self, sel, (IMP)amkProtocolProperties_dynamicGetter_id_safe, encoding);
//            break;
//    }
//    return YES;
//}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selName = NSStringFromSelector(sel);

    if ([selName hasPrefix:@"amkpp_"]) {
        // 动态生成 IMP
        IMP imp = imp_implementationWithBlock(^id(id _self){
            NSDictionary *dict = (NSDictionary *)_self;

            // 去掉 amk_ 前缀
            NSString *key = [selName substringFromIndex:6];
            id value = dict[key];
            
            // 获取方法签名，判断返回类型
            Method method = class_getInstanceMethod([_self class], sel);
            const char *retType = method_copyReturnType(method);
            id result = nil;

            if (retType[0] == '@') {
                // 对象类型
                result = value;
            } else if ([value isKindOfClass:[NSNumber class]]) {
                NSNumber *num = (NSNumber *)value;
                switch (retType[0]) {
                    case 'c': result = @([num charValue]); break;    // char / BOOL
                    case 'B': result = @([num boolValue]); break;    // BOOL
                    case 'i': result = @([num intValue]); break;     // int
                    case 's': result = @([num shortValue]); break;   // short
                    case 'l': result = @([num longValue]); break;    // long
                    case 'q': result = @([num longLongValue]); break;// long long / NSInteger
                    case 'C': result = @([num unsignedCharValue]); break;
                    case 'I': result = @([num unsignedIntValue]); break;
                    case 'S': result = @([num unsignedShortValue]); break;
                    case 'L': result = @([num unsignedLongValue]); break;
                    case 'Q': result = @([num unsignedLongLongValue]); break;
                    case 'f': result = @([num floatValue]); break;
                    case 'd': result = @([num doubleValue]); break;
                    default: result = value; break;
                }
            } else {
                result = value; // 其他类型直接返回
            }

            return result;
        });

        // 使用 "@@:" 表示返回对象，接收 id 和 SEL
        class_addMethod([self class], sel, imp, "@@:");
        return YES;
    }

    return [super resolveInstanceMethod:sel];
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
