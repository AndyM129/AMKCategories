//
//  NSString+AMKEmoji.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/12/18.
//

#import "NSString+AMKEmoji.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@implementation NSString (AMKEmoji)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSString amk_swizzleInstanceMethod:@selector(substringToIndex:) withMethod:@selector(AMKEmoji_NSString_substringToIndex:)];
    });
}

#pragma mark - Init Methods

#pragma mark - Properties

#pragma mark - Public Methods

/// 修复 Emoji 符号被截断的问题，参考：https://blog.csdn.net/BUG_delete/article/details/90694630
- (NSString *)AMKEmoji_NSString_substringToIndex:(NSUInteger)to {
    if (to<=0) return [self AMKEmoji_NSString_substringToIndex:to];
    if (self.length <= to) return self;
    
    NSRange rangeIndex = [self rangeOfComposedCharacterSequenceAtIndex:to];
    if (rangeIndex.length == 1) {
        NSRange rangeRange = [self rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, to)];
        return [self substringWithRange:rangeRange];
    } else {
        NSRange rangeRange = [self rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, to-1)];
        return [self substringWithRange:rangeRange];
    }
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
