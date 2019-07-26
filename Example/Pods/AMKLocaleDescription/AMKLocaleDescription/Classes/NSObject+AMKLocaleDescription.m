//
//  NSObject+AMKLocaleDescription.m
//  AMKLocaleDescription
//
//  Created by 孟昕欣 on 2019/1/28.
//

#import "NSObject+AMKLocaleDescription.h"

static NSString * const kLocaleDescriptionArrayBegin = @"[";
static NSString * const kLocaleDescriptionArrayEnd = @"]";
static NSString * const kLocaleDescriptionDictionaryBegin = @"{";
static NSString * const kLocaleDescriptionDictionaryEnd = @"}";
static NSString * const kLocaleDescriptionSetBegin = @"{(";
static NSString * const kLocaleDescriptionSetEnd = @")}";


@implementation NSSet(AMKLocaleDescription)

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"%@\n", kLocaleDescriptionSetBegin];
    NSUInteger count = self.count;
    __block NSInteger idx = 0;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * temp = nil;
        if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
            temp = [obj performSelector:@selector(descriptionWithLocale:) withObject:locale];
            temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        } else {
            temp = [obj performSelector:@selector(description) withObject:nil];
            if ([obj isKindOfClass:[NSString class]]) {
                temp = [NSString stringWithFormat:@"\"%@\"", temp];
            }
        }
        [string appendFormat:@"\t%@", temp];
        if (idx+1 != count) {
            [string appendString:@","];
        }
        [string appendString:@"\n"];
        idx += 1;
    }];
    [string appendString:kLocaleDescriptionSetEnd];
    return string;
    
}

@end

@implementation NSArray (AMKLocaleDescription)

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

//- (NSString *)description {
//    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
//}

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"%@\n", kLocaleDescriptionArrayBegin];
    NSUInteger count = self.count;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * temp = nil;
        if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
            temp = [obj performSelector:@selector(descriptionWithLocale:) withObject:locale];
            temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        } else {
            temp = [obj performSelector:@selector(description) withObject:nil];
            if ([obj isKindOfClass:[NSString class]]) {
                temp = [NSString stringWithFormat:@"\"%@\"", temp];
            }
        }
        [string appendFormat:@"\t%@", temp];
        if (idx+1 != count) {
            [string appendString:@","];
        }
        [string appendString:@"\n"];
    }];
    [string appendString:kLocaleDescriptionArrayEnd];
    return string;
}

@end

@implementation NSDictionary (AMKLocaleDescription)

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p> %@", NSStringFromClass([self class]), self, [self descriptionWithLocale:nil]];
}

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"%@\n", kLocaleDescriptionDictionaryBegin];
    NSUInteger count = self.allKeys.count;
    NSArray * allKeys = self.allKeys;
    BOOL canCom = YES;
    for (id temp in allKeys) {
        if ([temp respondsToSelector:@selector(compare:)] == NO) {
            canCom = NO;
            break;
        }
    }
    if (canCom) {
        allKeys = [self.allKeys sortedArrayUsingSelector:@selector(compare:)];
    }
    for (id key in allKeys) {
        NSInteger index = [self.allKeys indexOfObject:key];
        id value = [self objectForKey:key];
        NSString * temp = nil;
        if ([value respondsToSelector:@selector(descriptionWithLocale:)]) {
            temp = [value performSelector:@selector(descriptionWithLocale:) withObject:locale];
            temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        } else {
            temp = [value performSelector:@selector(description) withObject:nil];
            if ([value isKindOfClass:[NSString class]]) {
                temp = [NSString stringWithFormat:@"\"%@\"", temp];
            }
        }
        [string appendFormat:@"\t%@ = %@", key, temp];
        if (index+1 != count) {
            [string appendString:@","];
        }
        [string appendString:@"\n"];
    }
    [string appendString:kLocaleDescriptionDictionaryEnd];
    return string;
    
}

@end
