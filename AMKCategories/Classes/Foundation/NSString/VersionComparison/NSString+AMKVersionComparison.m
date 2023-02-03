//
//  NSString+AMKVersionComparison.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2023/2/3.
//

#import "NSString+AMKVersionComparison.h"

// 定义改宏，可启用 Debug
//#define AMKVersionComparisonDebug


#ifdef AMKVersionComparisonDebug
#   define AMKVersionComparisonLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#   define AMKVersionComparisonLog(...) {}
#endif

@implementation NSString (AMKVersionComparison)

- (BOOL)amk_containsVersion:(NSString *)versionString {
    BOOL contains = NO;
    if (self.length) {
        // 删除两端空白符
        versionString = [versionString stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        
        // 将当前字符串，以","拆分为多个版本区间，例如 "1.2.3, 4.5.6~7.8.9" 拆分为 ["1.2.3", "4.5.6~7.8.9"]
        NSString *versionRangeString = [self stringByReplacingOccurrencesOfString:@"*" withString:[NSString stringWithFormat:@"%ld", NSIntegerMax]];
        NSArray<NSString *> *versionRanges = [versionRangeString componentsSeparatedByString:@","];
        
        // 遍历每一个版本区间
        for (NSString *versionRange in versionRanges) {
            // 将当前版本区间，以"~"拆分为 开始、结束的版本号，并逐个判断，例如 "1.2.3~5.6.7" 解析为 ["1.2.3", "5.6.7"]
            NSArray<NSString *> *versionRangeComponents = [[versionRange stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] componentsSeparatedByString:@"~"];
            
            // 无效版本
            if (versionRangeComponents.count == 0) {
                continue;
            }
            
            // 子版本，例如 "1.2.3" 解析为 ["1.2.3"]
            else if (versionRangeComponents.count == 1) {
                contains = [versionString hasPrefix:versionRangeComponents[0]];
            }
            
            // 版本区间，例如 "1.2.3~5.6.7" 解析为 ["1.2.3", "5.6.7"]
            else {
                if ([versionRangeComponents[0] compare:versionString options:NSNumericSearch] != NSOrderedDescending) {
                    if ([versionRangeComponents[1] compare:versionString options:NSNumericSearch] == NSOrderedDescending) {
                        contains = YES;
                    }
                }
            }
            
            // 已包含则结束循环
            if (contains) {
                break;
            }
        }
    }
    AMKVersionComparisonLog(@"\"%@\" %@包含指定版本 \"%@\"", self, (contains ? @"  " : @"不"), versionString);
    return contains;
}

@end

#pragma mark - 单测

#ifdef AMKVersionComparisonDebug

@implementation NSString (AMKVersionComparisonUnitTest)

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test_amk_containsVersion];
    });
}

+ (void)test_amk_containsVersion {
    // 子版本
    NSAssert([@"1" amk_containsVersion:@"0"] == NO, @"");
    NSAssert([@"1" amk_containsVersion:@"1"] == YES, @"");
    NSAssert([@"1" amk_containsVersion:@"1.0"] == YES, @"");
    NSAssert([@"1.0" amk_containsVersion:@"1"] == NO, @"");
    NSAssert([@"1.0" amk_containsVersion:@"1.0"] == YES, @"");
    NSAssert([@"1.0" amk_containsVersion:@"1.0.0"] == YES, @"");
    
    NSAssert([@"1.2.3" amk_containsVersion:@"0"] == NO, @"");
    NSAssert([@"1.2.3" amk_containsVersion:@"1.0"] == NO, @"");
    NSAssert([@"1.2.3" amk_containsVersion:@"1.2"] == NO, @"");
    NSAssert([@"1.2.3" amk_containsVersion:@"1.2.3"] == YES, @"");
    NSAssert([@"1.2.3" amk_containsVersion:@"1.2.3.4"] == YES, @"");
    NSAssert([@"1.2.3" amk_containsVersion:@"1.2.3.15"] == YES, @"");
    NSAssert([@"1.2.3" amk_containsVersion:@"1.3"] == NO, @"");
    NSAssert([@"1.2.3" amk_containsVersion:@"2.3"] == NO, @"");
    
    // 版本区间
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"0"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"1.0"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"1.0.0"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"1.2"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"1.2.3"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"1.2.3.4"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"1.2.3.15"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"1.2.4"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"1.3"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"2.3"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"2.3.4"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"3.4.5"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"4.5"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"4.5.0"] == YES, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"4.5.10"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"4.5.10.20"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"4.5.6"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"4.5.6.7"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"4.5.6.78"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"4.6.7"] == NO, @"");
    NSAssert([@"1.2.3~4.5.6" amk_containsVersion:@"5.6.7"] == NO, @"");
    
    // 混合版本
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"1.0"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"6"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"6.0"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"6.1.2"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"7"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"7.0"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"7.0.0"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"7.0.10"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.0"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.0.0"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.0.1"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.1"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.3"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.30"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.30.40"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.40"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.40.50"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.50"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.50.60"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.60"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.70"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.0.70.80"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.1.00"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.1.1"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.1.10"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.1.20"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.2"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"8.2.3"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"9"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"9.0"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"9.0.10"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9, 10~*" amk_containsVersion:@"9"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9, 10~*" amk_containsVersion:@"9.0"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9, 10~*" amk_containsVersion:@"9.0.10"] == NO, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"10"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"10.0"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"10.20.30"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"11.0"] == YES, @"");
    NSAssert([@"6, 7.0, 8.0.0, 8.0.30~8.0.50, 8.0.70~8.1.10, 8.2~9.0, 10~*" amk_containsVersion:@"21.0.45"] == YES, @"");
    
    AMKVersionComparisonLog(@"✅ %@ 已通过全部单测", NSStringFromSelector(@selector(amk_containsVersion:)));
}

@end

#endif

