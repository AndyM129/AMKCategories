//
//  NSDictionary+AMKObjectForKey.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/8/3.
//

#import "NSDictionary+AMKObjectForKey.h"
#import "NSString+AMKDate.h"
#import <objc/message.h>

@interface NSPredicate(_AMKObjectForKey)

/** 无符号整数 */
+ (instancetype)amk_unsignedIntegerPredicate;

/** 无符号浮点数 */
+ (instancetype)amk_unsignedDoublePredicate;

/** 无符号数字 */
+ (instancetype)amk_unsignedDigitalPredicate;

@end

@implementation NSPredicate(_AMKObjectForKey)

+ (instancetype)amk_unsignedIntegerPredicate {
    static NSPredicate *predicate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^\\d+$"];
    });
    return predicate;
}

+ (instancetype)amk_unsignedDoublePredicate {
    static NSPredicate *predicate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^\\d+\\.\\d+?$"];
    });
    return predicate;
}

+ (instancetype)amk_unsignedDigitalPredicate {
    static NSPredicate *predicate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^\\d+(\\.\\d+)?$"];
    });
    return predicate;
}

@end

#pragma mark -
#pragma mark -

@interface NSObject (_AMKObjectForKey_CrashProtector)

- (id _Nullable)amk_objectForKeyPathWithComponents:(NSArray<NSString *> *_Nullable)keyPathComponents;

@end

@implementation NSObject (_AMKObjectForKey_CrashProtector)

- (BOOL)amk_boolForKey:(id _Nullable)key {
    return [self amk_boolForKeyPath:key separatingWithString:nil];
}

- (BOOL)amk_boolForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_boolForKeyPath:keyPath separatingWithString:@"."];
}

- (BOOL)amk_boolForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    return ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) ? [value boolValue] : NO;
}

- (float)amk_floatForKey:(id _Nullable)key {
    return [self amk_floatForKeyPath:key separatingWithString:nil];
}

- (float)amk_floatForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_floatForKeyPath:keyPath separatingWithString:@"."];
}

- (float)amk_floatForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    return [value respondsToSelector:@selector(floatValue)] ? [value floatValue] : 0.f;
}

- (double)amk_doubleForKey:(id _Nullable)key {
    return [self amk_doubleForKeyPath:key separatingWithString:nil];
}

- (double)amk_doubleForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_doubleForKeyPath:keyPath separatingWithString:@"."];
}

- (double)amk_doubleForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    return [value respondsToSelector:@selector(doubleValue)] ? [value doubleValue] : 0.f;
}

- (NSInteger)amk_integerForKey:(id _Nullable)key {
    return [self amk_integerForKeyPath:key separatingWithString:nil];
}

- (NSInteger)amk_integerForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_integerForKeyPath:keyPath separatingWithString:@"."];
}

- (NSInteger)amk_integerForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    return [value respondsToSelector:@selector(integerValue)] ? [value integerValue] : 0;
}

- (CGPoint)amk_CGPointForKey:(id _Nullable)key {
    return [self amk_CGPointForKeyPath:key separatingWithString:nil];
}

- (CGPoint)amk_CGPointForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_CGPointForKeyPath:keyPath separatingWithString:@"."];
}

- (CGPoint)amk_CGPointForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSValue class]]) return [value CGPointValue];
    if ([value isKindOfClass:[NSString class]]) return CGPointFromString(value);
    return CGPointZero;
}

- (CGVector)amk_CGVectorForKey:(id _Nullable)key {
    return [self amk_CGVectorForKeyPath:key separatingWithString:nil];
}

- (CGVector)amk_CGVectorForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_CGVectorForKeyPath:keyPath separatingWithString:@"."];
}

- (CGVector)amk_CGVectorForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSValue class]]) return [value CGVectorValue];
    if ([value isKindOfClass:[NSString class]]) return CGVectorFromString(value);
    return CGVectorMake(0, 0);
}

- (CGSize)amk_CGSizeForKey:(id _Nullable)key {
    return [self amk_CGSizeForKeyPath:key separatingWithString:nil];
}

- (CGSize)amk_CGSizeForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_CGSizeForKeyPath:keyPath separatingWithString:@"."];
}

- (CGSize)amk_CGSizeForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSValue class]]) return [value CGSizeValue];
    if ([value isKindOfClass:[NSString class]]) return CGSizeFromString(value);
    return CGSizeZero;
}

- (CGRect)amk_CGRectForKey:(id _Nullable)key {
    return [self amk_CGRectForKeyPath:key separatingWithString:nil];
}

- (CGRect)amk_CGRectForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_CGRectForKeyPath:keyPath separatingWithString:@"."];
}

- (CGRect)amk_CGRectForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSValue class]]) return [value CGRectValue];
    if ([value isKindOfClass:[NSString class]]) return CGRectFromString(value);
    return CGRectZero;
}

- (CGAffineTransform)amk_CGAffineTransformForKey:(id _Nullable)key {
    return [self amk_CGAffineTransformForKeyPath:key separatingWithString:nil];
}

- (CGAffineTransform)amk_CGAffineTransformForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_CGAffineTransformForKeyPath:keyPath separatingWithString:@"."];
}

- (CGAffineTransform)amk_CGAffineTransformForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSValue class]]) return [value CGAffineTransformValue];
    if ([value isKindOfClass:[NSString class]]) return CGAffineTransformFromString(value);
    return CGAffineTransformIdentity;
}

- (UIEdgeInsets)amk_UIEdgeInsetsForKey:(id _Nullable)key {
    return [self amk_UIEdgeInsetsForKeyPath:key separatingWithString:nil];
}

- (UIEdgeInsets)amk_UIEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_UIEdgeInsetsForKeyPath:keyPath separatingWithString:@"."];
}

- (UIEdgeInsets)amk_UIEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSValue class]]) return [value UIEdgeInsetsValue];
    if ([value isKindOfClass:[NSString class]]) return UIEdgeInsetsFromString(value);
    return UIEdgeInsetsZero;
}

- (NSDirectionalEdgeInsets)amk_NSDirectionalEdgeInsetsForKey:(id _Nullable)key API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0)) {
    return [self amk_NSDirectionalEdgeInsetsForKeyPath:key separatingWithString:nil];
}

- (NSDirectionalEdgeInsets)amk_NSDirectionalEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0)) {
    return [self amk_NSDirectionalEdgeInsetsForKeyPath:keyPath separatingWithString:@"."];
}

- (NSDirectionalEdgeInsets)amk_NSDirectionalEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator API_AVAILABLE(ios(11.0),tvos(11.0),watchos(4.0)) {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSValue class]]) return [value directionalEdgeInsetsValue];
    if ([value isKindOfClass:[NSString class]]) return NSDirectionalEdgeInsetsFromString(value);
    return NSDirectionalEdgeInsetsZero;
}

- (UIOffset)amk_UIOffsetForKey:(id _Nullable)key {
    return [self amk_UIOffsetForKeyPath:key separatingWithString:nil];
}

- (UIOffset)amk_UIOffsetForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_UIOffsetForKeyPath:keyPath separatingWithString:@"."];
}

- (UIOffset)amk_UIOffsetForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSValue class]]) return [value UIOffsetValue];
    if ([value isKindOfClass:[NSString class]]) return UIOffsetFromString(value);
    return UIOffsetZero;
}

- (NSData *)amk_dataForKey:(id _Nullable)key {
    return [self amk_dataForKeyPath:key separatingWithString:nil];
}

- (NSData *)amk_dataForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_dataForKeyPath:keyPath separatingWithString:@"."];
}

- (NSData *)amk_dataForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    return [value isKindOfClass:[NSData class]] ? value : nil;
}

- (NSString *_Nullable)amk_stringForKey:(id _Nullable)key {
    return [self amk_stringForKeyPath:key separatingWithString:nil default:nil];
}

- (NSString *_Nullable)amk_stringForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_stringForKeyPath:keyPath separatingWithString:@"." default:nil];
}

- (NSString *_Nullable)amk_stringForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    return [self amk_stringForKeyPath:keyPath separatingWithString:separator default:nil];
}

- (NSString *_Nullable)amk_stringForKey:(id _Nullable)key default:(NSString *)defaultValue {
    return [self amk_stringForKeyPath:key separatingWithString:nil default:defaultValue];
}

- (NSString *_Nullable)amk_stringForKeyPath:(NSString *_Nullable)keyPath default:(NSString *)defaultValue {
    return [self amk_stringForKeyPath:keyPath separatingWithString:@"." default:defaultValue];
}

- (NSString *_Nullable)amk_stringForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator default:(NSString *)defaultValue {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    
    NSString *string = nil;
    if (value == NSNull.null) {
        string = nil;
    } else if ([value isKindOfClass:[NSString class]]) {
        string = value;
    } else if ([value respondsToSelector:@selector(stringValue)]) {
        string = [value stringValue];
    }
    string = string.length ? string : (defaultValue ?: string);
    return string;
}

- (NSURL *_Nullable)amk_URLForKey:(id _Nullable)key {
    return [self amk_URLForKeyPath:key separatingWithString:nil];
}

- (NSURL *_Nullable)amk_URLForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_URLForKeyPath:keyPath separatingWithString:@"."];
}

- (NSURL *_Nullable)amk_URLForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSURL class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        return [NSURL URLWithString:value];
    } else if ([value respondsToSelector:@selector(stringValue)]) {
        return [NSURL URLWithString:[value stringValue]];
    }
    return nil;
}

- (NSDate *_Nullable)amk_dateForKey:(id _Nullable)key {
    return [self amk_dateForKeyPath:key separatingWithString:nil];
}

- (NSDate *_Nullable)amk_dateForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_dateForKeyPath:keyPath separatingWithString:@"."];
}

- (NSDate *_Nullable)amk_dateForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    
    // 若value是NSDate则直接返回
    if ([value isKindOfClass:[NSDate class]]) return value;
    
    // 若value是NSNumber则将其转为字符串
    if ([value isKindOfClass:NSNumber.class]) value = [value stringValue];
    
    // 若value是字符串
    if ([value isKindOfClass:[NSString class]]) {
        // 若是无符号整数字符串，则按照时间戳解析(10位之后的按毫秒数处理)
        if ([NSPredicate.amk_unsignedIntegerPredicate evaluateWithObject:value]) {
            if ([value length] <= 10) {
                return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
            } else {
                return [NSDate dateWithTimeIntervalSince1970:([value doubleValue] / pow(10, [value length]-10))];
            }
        }
        
        // 若是无符号浮点数字符串，则按照时间戳解析
        if ([NSPredicate.amk_unsignedDoublePredicate evaluateWithObject:value]) {
            return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        }
        
        // 若value是非数字字符串，则将其格式化解析返回
        return [value amk_date];
    }
    
    // 无法解析则返回空
    return nil;
}

- (NSArray *)amk_arrayForKey:(id _Nullable)key {
    return [self amk_arrayForKeyPath:key separatingWithString:nil];
}

- (NSArray *)amk_arrayForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_arrayForKeyPath:keyPath separatingWithString:@"."];
}

- (NSArray *)amk_arrayForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    return [value isKindOfClass:[NSArray class]] ? value : nil;
}

- (NSDictionary *)amk_dictionaryForKey:(id _Nullable)key {
    return [self amk_dictionaryForKeyPath:key separatingWithString:nil];
}

- (NSDictionary *)amk_dictionaryForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_dictionaryForKeyPath:keyPath separatingWithString:@"."];
}

- (NSDictionary *)amk_dictionaryForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    return [value isKindOfClass:[NSDictionary class]] ? value : nil;
}

- (id _Nullable)amk_objectForKey:(id _Nullable)key asClass:(Class _Nonnull)cls {
    return [self amk_objectForKeyPath:key separatingWithString:nil asClass:cls];
}

- (id _Nullable)amk_objectForKeyPath:(NSString * _Nullable)keyPath asClass:(Class _Nonnull)cls {
    return [self amk_objectForKeyPath:keyPath separatingWithString:@"." asClass:cls];
}

- (id _Nullable)amk_objectForKeyPath:(NSString * _Nullable)keyPath separatingWithString:(NSString * _Nullable)separator asClass:(Class _Nonnull)cls {
    id object = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    return [object isKindOfClass:cls] ? object : nil;
}

- (id _Nullable)amk_objectForKey:(id _Nullable)key {
    return [self amk_objectForKeyPath:key separatingWithString:nil];
}

- (id _Nullable)amk_objectForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_objectForKeyPath:keyPath separatingWithString:@"."];
}

- (id _Nullable)amk_objectForKeyPath:(NSString *_Nullable )keyPath separatingWithString:(NSString *_Nullable)separator {
    // 若 keyPath 是字符串，则解析出 keyPathComponents
    NSArray<NSString *> *keyPathComponents = nil;
    if (keyPath && [keyPath isKindOfClass:NSString.class] && keyPath.length && separator && [separator isKindOfClass:NSString.class] && separator.length) {
        keyPathComponents = [keyPath componentsSeparatedByString:separator];
    } else {
        if ([keyPath isKindOfClass:NSArray.class]) {
            keyPathComponents = (NSArray *)keyPath;
        } else if ([keyPath isKindOfClass:[NSString class]] && keyPath.length) {
            keyPathComponents = @[keyPath];
        }
    }
    
    // 默认处理
    return [self amk_objectForKeyPathWithComponents:keyPathComponents];
}

- (id _Nullable)amk_objectForKeyPathWithComponents:(NSArray<NSString *> *)keyPathComponents {
    return nil;
}

@end

#pragma mark -
#pragma mark -

@implementation NSArray (_AMKObjectForKey)

- (id _Nullable)amk_objectForKeyPathWithComponents:(NSArray<NSString *> *_Nullable)keyPathComponents {
    __block NSMutableArray *objectsForKeyPathComponents = [NSMutableArray arrayWithCapacity:keyPathComponents.count];
    [self enumerateObjectsUsingBlock:^(id _Nonnull object, NSUInteger objectIndex, BOOL * _Nonnull stop) {
        if ([object isKindOfClass:NSDictionary.class] || [object isKindOfClass:NSArray.class]) {
            id objectForKeyPathComponents = [object amk_objectForKeyPathWithComponents:keyPathComponents];
            if (objectForKeyPathComponents) {
                [objectsForKeyPathComponents addObject:objectForKeyPathComponents];
            }
        }
    }];
    return objectsForKeyPathComponents;
}

@end

#pragma mark -
#pragma mark -

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wincomplete-implementation"

@implementation NSDictionary (_AMKObjectForKey)

- (id _Nullable)amk_objectForKeyPathWithComponents:(NSArray<NSString *> *)keyPathComponents {
    // 无效参数，则直接系统方式返回
    if (!keyPathComponents) {
        return [self objectForKey:keyPathComponents];
    }
    
    // 不是有效数组，则直接系统方式返回
    if (![keyPathComponents isKindOfClass:NSArray.class] || !keyPathComponents.count) {
        return [self objectForKey:keyPathComponents];
    }
    
    // 若仅有一个节点，则直接系统方式返回
    if (keyPathComponents.count <= 1) {
        return [self objectForKey:keyPathComponents.firstObject];
    }
    
    // 解析出keyPath对应节点对象
    __block id objectForKeyPathComponents = self;
    [keyPathComponents enumerateObjectsUsingBlock:^(NSString *_Nonnull keyPathComponent, NSUInteger keyPathComponentIndex, BOOL * _Nonnull keyPathComponentStop) {
        // 若当前节点为空则停止解析
        if (!objectForKeyPathComponents) {
            *keyPathComponentStop = YES;
        }
        // 若当前节点是字典，则按key取值
        else if ([objectForKeyPathComponents isKindOfClass:NSDictionary.class]) {
            objectForKeyPathComponents = [objectForKeyPathComponents objectForKey:keyPathComponent];
        }
        // 若当前节点是数组，则key须为有效数字 并取出对应元素
        else if ([objectForKeyPathComponents isKindOfClass:NSArray.class] && [NSPredicate.amk_unsignedIntegerPredicate evaluateWithObject:keyPathComponent]){
            NSInteger index = keyPathComponent.integerValue;
//            NSInteger count = [(NSArray *)objectForKeyPathComponents count];
            objectForKeyPathComponents = (index>=0 && index<[(NSArray *)objectForKeyPathComponents count]) ? [(NSArray *)objectForKeyPathComponents objectAtIndex:index] : nil;
        }
        // 若当前节点是数组，且key不是有效数字，将数组中 每个字典 指定key取出，最终合并为数组返回
        else if ([objectForKeyPathComponents isKindOfClass:NSArray.class]){
            @autoreleasepool {
                __block NSMutableArray *objectsForKeyPathComponents = [NSMutableArray arrayWithCapacity:[(NSArray *)objectForKeyPathComponents count]];
                [(NSArray *)objectForKeyPathComponents enumerateObjectsUsingBlock:^(id _Nonnull enumeratedObjectForKeyPathComponents, NSUInteger enumeratedObjectForKeyPathComponentsIndex, BOOL * _Nonnull enumeratedObjectForKeyPathComponentsStop) {
                    NSArray *subKeyPathComponents = [keyPathComponents subarrayWithRange:NSMakeRange(keyPathComponentIndex, keyPathComponents.count-keyPathComponentIndex)];
                    if ([enumeratedObjectForKeyPathComponents isKindOfClass:NSDictionary.class] || [enumeratedObjectForKeyPathComponents isKindOfClass:NSArray.class]) {
                        id objectForSubKeyPath = [enumeratedObjectForKeyPathComponents amk_objectForKeyPathWithComponents:subKeyPathComponents];
                        if (objectForSubKeyPath) {
                            [objectsForKeyPathComponents addObject:objectForSubKeyPath];
                        }
                    }
                }];
                objectForKeyPathComponents = objectsForKeyPathComponents ?: nil;
                *keyPathComponentStop = YES;
            }
        }
        // 其他未处理情况直接将当前节点置为空
        else {
            objectForKeyPathComponents = nil;
        }
    }];
    return objectForKeyPathComponents;
}

@end

#pragma clang diagnostic pop
