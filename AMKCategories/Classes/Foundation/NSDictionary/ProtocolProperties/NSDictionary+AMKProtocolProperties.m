//
//  NSDictionary+AMKProtocolProperties.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/9/5.
//

#import "NSDictionary+AMKProtocolProperties.h"
#import <objc/runtime.h>

static NSString *kProtocolPropertyNamePrefix = @"amkpp_";

@interface NSString (AMKProtocolProperties)
- (BOOL)amkProtocolProperties_extractKey:(NSString * _Nullable * _Nullable)outKey valueType:(NSString * _Nullable * _Nullable)outValueType;
@end

@implementation NSString (AMKProtocolProperties)

- (BOOL)amkProtocolProperties_extractKey:(NSString * _Nullable * _Nullable)outKey valueType:(NSString * _Nullable * _Nullable)outValueType {
    // 将值重置
    if (outKey) *outKey = nil;
    if (outValueType) *outValueType = nil;
    
    // 没有指定协议属性名前缀，则不再处理
    if (![self hasPrefix:kProtocolPropertyNamePrefix]) {
        return NO;
    }
    
    NSString *rest = [self substringFromIndex:kProtocolPropertyNamePrefix.length];
    NSRange sep = [rest rangeOfString:@"__" options:NSBackwardsSearch];
    
    // 没有 valueType，全部当成 key
    if (sep.location == NSNotFound) {
        if (outKey) *outKey = rest;
    }
    // 可能有 valueType
    else {
        NSString *maybeValueType = [rest substringFromIndex:sep.location + sep.length];
        
        // 没有 valueType，全部当成 key
        if (!maybeValueType.length || ![maybeValueType hasSuffix:@"Value"]) {
            if (outKey) *outKey = rest;
        }
        // 有 valueType
        else {
            if (outKey) *outKey = [rest substringToIndex:sep.location];
            if (outValueType) *outValueType = maybeValueType;
        }
    }
    return YES;
}

@end

#pragma mark -
#pragma mark -

@implementation NSDictionary (AMKProtocolProperties)

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
//    static NSRegularExpression *kProtocolPropertyNameRegex = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSError *error = nil;
//        NSString *pattern = [NSString stringWithFormat:@"^%@([A-Za-z0-9_]+)(?:__([A-Za-z0-9_]*Value))?$", kProtocolPropertyNamePrefix];
//        kProtocolPropertyNameRegex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
//        NSAssert(kProtocolPropertyNameRegex != nil, @"kProtocolPropertyNameRegex init failed: %@", error);
//    });
    
    NSString *key = nil, *valueType = nil;
    NSString *selName = NSStringFromSelector(sel);
    if ([selName amkProtocolProperties_extractKey:&key valueType:&valueType]) {
//        NSTextCheckingResult *match = [kProtocolPropertyNameRegex firstMatchInString:selName options:0 range:NSMakeRange(0, selName.length)];
//        NSString *key = [match rangeAtIndex:1].location == NSNotFound ? nil : [selName substringWithRange:[match rangeAtIndex:1]];
//        NSString *valueType = [match rangeAtIndex:2].location == NSNotFound ? nil : [selName substringWithRange:[match rangeAtIndex:2]];
        
        IMP imp = NULL;
        const char *types = NULL;
        
        if (!valueType.length) { // 无类型后缀，直接返回对象
            imp = imp_implementationWithBlock(^id(NSDictionary *selfDict){
                id value = selfDict[key];
                return value == NSNull.null ? nil : value;
            });
            types = "@@:";
        }
        else if ([valueType isEqualToString:@"stringValue"]) {
            imp = imp_implementationWithBlock(^NSString *(NSDictionary *selfDict){
                id value = selfDict[key];
                if ([value isKindOfClass:NSString.class]) {
                    return value;
                }
                return [value respondsToSelector:@selector(stringValue)] ? [value stringValue] : nil;
            });
            types = "@@:";
        }
        else if ([valueType isEqualToString:@"integerValue"]) {
            imp = imp_implementationWithBlock(^NSInteger(NSDictionary *selfDict){
                id value = selfDict[key];
                return [value respondsToSelector:@selector(integerValue)] ? [value integerValue] : 0;
            });
            types = "q@:"; // NSInteger = long long (64-bit)
        }
        else if ([valueType isEqualToString:@"boolValue"]) {
            imp = imp_implementationWithBlock(^BOOL(NSDictionary *selfDict){
                id value = selfDict[key];
                return [value respondsToSelector:@selector(boolValue)] ? [value boolValue] : NO;
            });
            types = "B@:";
        }
        else if ([valueType isEqualToString:@"doubleValue"]) {
            imp = imp_implementationWithBlock(^double(NSDictionary *selfDict){
                id value = selfDict[key];
                return [value respondsToSelector:@selector(doubleValue)] ? [value doubleValue] : 0.0;
            });
            types = "d@:";
        }
        else { // 未知后缀，按对象返回
            imp = imp_implementationWithBlock(^id(NSDictionary *selfDict){
                id value = selfDict[key];
                return value == NSNull.null ? nil : value;
            });
            types = "@@:";
        }
        
        class_addMethod(self, sel, imp, types);
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

@end
