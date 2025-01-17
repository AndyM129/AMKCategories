//
//  AMKExampleViewModel.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleViewModel.h"
#import <YYModel/YYModel.h>

@implementation AMKExampleViewModel

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Public Methods

- (NSString *)treeDescription {
    return [self treeDescriptionWithPrefix:nil isLast:NO];
    
//    NSMutableString *treeDescription = @"".mutableCopy;
//    
//    [treeDescription];
//    
//    
//    [strings addObject:[NSString stringWithFormat:@"%@：%@", self.title, self.subtitle]];
//    
//    [self.subExamples enumerateObjectsUsingBlock:^(AMKExampleViewModel * _Nonnull subExample, NSUInteger idx, BOOL * _Nonnull stop) {
////        [strings addObject:[NSString stringWithFormat:@" %@━ %@：%@", (idx < self.subExamples.count-1 ? @"┣" : @"┗"), subExample.title, subExample.subtitle]];
//        [strings addObject:subExample];
//    }];
//    
////    for (NSString *key in allKeys) {
////        id value = dict[key];
////        NSLog(@"%@├── %@", prefix, key);
////        
////        if ([value isKindOfClass:[NSDictionary class]]) {
////            NSString *newPrefix = [prefix stringByAppendingString:@"│   "];
////            printDictionaryTree((NSDictionary *)value, newPrefix);
////        } else if ([value isKindOfClass:[NSArray class]]) {
////            NSLog(@"%@│   └── (NSArray with %lu elements)", prefix, (unsigned long)[(NSArray *)value count]);
////        } else {
////            NSLog(@"%@│   └── %@", prefix, value);
////        }
////    }
//    NSString *treeDescription = [strings componentsJoinedByString:@"\n"];
//    return treeDescription;
}

- (NSString *)treeDescriptionWithPrefix:(NSString *)prefix isLast:(BOOL)isLast {
//    NSString *curPrefix = [NSString stringWithFormat:@"%@ %@━ ", prefix, (isLast ? @"┗" : @"┣")];
//    NSString *subPrefix = [NSString stringWithFormat:@"%@ %@━ ", prefix, (isLast ? @"┗" : @"┣")];
    
    __block NSMutableString *treeDescription = @"".mutableCopy;
    [treeDescription appendFormat:@"%@%@%@%@\n", (prefix ?: @""), (self.title ?: @""), (self.subtitle.length ? @" —— " : @""), (self.subtitle ?: @"")];
    [self.subExamples enumerateObjectsUsingBlock:^(AMKExampleViewModel * _Nonnull subExample, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *subExamplePrefix = [NSString stringWithFormat:@"%@ %@━ ", prefix, (idx < self.subExamples.count-1 ? @"┣" : @"┗")];
//        [treeDescription appendFormat:@"%@", [subExample treeDescriptionWithPrefix:subExamplePrefix]];
//        [strings addObject:[NSString stringWithFormat:@" %@━ %@：%@", (idx < self.subExamples.count-1 ? @"┣" : @"┗"), subExample.title, subExample.subtitle]];
//        [strings addObject:subExample];
        
        BOOL isLastSub = idx == self.subExamples.count-1;
        NSString *parentExamplePrefix = @"";
        if (prefix.length) {
            if (isLast) {
                parentExamplePrefix = [NSString stringWithFormat:@"%@%@", [prefix substringToIndex:prefix.length - 4], @"    "];
            } else {
                parentExamplePrefix = [NSString stringWithFormat:@"%@%@", [prefix substringToIndex:prefix.length - 4], @" ┃  "];
            }
        }
        NSString *subExamplePrefix = [NSString stringWithFormat:@"%@ %@━ ", parentExamplePrefix, (isLastSub ? @"┗" : @"┣")];
        [treeDescription appendFormat:@"%@", [subExample treeDescriptionWithPrefix:subExamplePrefix isLast:isLastSub]];
    }];
    
    return treeDescription;
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"subExamples" : AMKExampleViewModel.class
    };
}

#pragma mark - Helper Methods

@end
