//
//  NSDictionary+AMKObjectForKey.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/8/3.
//

#import "NSDictionary+AMKObjectForKey.h"
#import <objc/message.h>

/** Parse string to date.（参考 YYModel <https://github.com/ibireme/YYModel>） */
#define amk_force_inline __inline__ __attribute__((always_inline))
static amk_force_inline NSDate *_AMKNSDateFromString(__unsafe_unretained NSString *string) {
    typedef NSDate* (^AMKNSDateParseBlock)(NSString *string);
#   define kParserNum 34
    static AMKNSDateParseBlock blocks[kParserNum + 1] = {0};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            /*
             2014-01-20  // Google
             */
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter.dateFormat = @"yyyy-MM-dd";
            blocks[10] = ^(NSString *string) { return [formatter dateFromString:string]; };
        }
        
        {
            /*
             2014-01-20 12:24:48
             2014-01-20T12:24:48   // Google
             2014-01-20 12:24:48.000
             2014-01-20T12:24:48.000
             */
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            formatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter1.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
            
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
            formatter3.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter3.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter3.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
            
            NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
            formatter4.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter4.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            formatter4.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
            
            blocks[19] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter1 dateFromString:string];
                } else {
                    return [formatter2 dateFromString:string];
                }
            };
            
            blocks[23] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter3 dateFromString:string];
                } else {
                    return [formatter4 dateFromString:string];
                }
            };
        }
        
        {
            /*
             2014-01-20T12:24:48Z        // Github, Apple
             2014-01-20T12:24:48+0800    // Facebook
             2014-01-20T12:24:48+12:00   // Google
             2014-01-20T12:24:48.000Z
             2014-01-20T12:24:48.000+0800
             2014-01-20T12:24:48.000+12:00
             */
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
            
            blocks[20] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[24] = ^(NSString *string) { return [formatter dateFromString:string]?: [formatter2 dateFromString:string]; };
            blocks[25] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[28] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
            blocks[29] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }
        
        {
            /*
             Fri Sep 04 00:12:21 +0800 2015 // Weibo, Twitter
             Fri Sep 04 00:12:21.000 +0800 2015
             */
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
            
            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            formatter2.dateFormat = @"EEE MMM dd HH:mm:ss.SSS Z yyyy";
            
            blocks[30] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[34] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }
    });
    if (!string) return nil;
    if (string.length > kParserNum) return nil;
    AMKNSDateParseBlock parser = blocks[string.length];
    if (!parser) return nil;
    return parser(string);
#   undef kParserNum
}
#undef amk_force_inline



#pragma mark -



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



@interface NSArray(_AMKObjectForKey)
- (id _Nullable)amk_objectForKeyPathWithComponents:(NSArray<NSString *> *_Nullable)keyPathComponents;
@end

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



@implementation NSDictionary (AMKObjectForKey)

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

- (NSDirectionalEdgeInsets)amk_NSDirectionalEdgeInsetsForKey:(id _Nullable)key {
    return [self amk_NSDirectionalEdgeInsetsForKeyPath:key separatingWithString:nil];
}

- (NSDirectionalEdgeInsets)amk_NSDirectionalEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_NSDirectionalEdgeInsetsForKeyPath:keyPath separatingWithString:@"."];
}

- (NSDirectionalEdgeInsets)amk_NSDirectionalEdgeInsetsForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
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
    return [self amk_stringForKeyPath:key separatingWithString:nil];
}

- (NSString *_Nullable)amk_stringForKeyPath:(NSString *_Nullable)keyPath {
    return [self amk_stringForKeyPath:keyPath separatingWithString:@"."];
}

- (NSString *_Nullable)amk_stringForKeyPath:(NSString *_Nullable)keyPath separatingWithString:(NSString *_Nullable)separator {
    id value = [self amk_objectForKeyPath:keyPath separatingWithString:separator];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    }
    return nil;
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
        return _AMKNSDateFromString(value);
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
        keyPathComponents = (id)keyPath;
    }
    
    // 默认处理
    return [self amk_objectForKeyPathWithComponents:keyPathComponents];
}

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


