//
//  NSString+AMKURL.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2023/2/7.
//

#import "NSString+AMKURL.h"

@implementation NSString (AMKURL)

- (NSMutableDictionary<NSString *, NSString *> *)amk_urlQueryKeyValues {
    __block NSMutableDictionary<NSString *, NSString *> *urlQueryKeyValues = nil;
    
    if (self.length) {
        NSRange questionMarkRange = [self rangeOfString:@"?"];
        NSString *query = questionMarkRange.location == NSNotFound ? self : [self substringFromIndex:questionMarkRange.location + questionMarkRange.length];
        
        if (query.length) {
            NSArray<NSString *> *urlQueryKeyValueStrings = [query componentsSeparatedByString:@"&"];
            urlQueryKeyValues = [NSMutableDictionary dictionaryWithCapacity:urlQueryKeyValueStrings.count];
            
            [urlQueryKeyValueStrings enumerateObjectsUsingBlock:^(NSString * _Nonnull urlQueryKeyValueString, NSUInteger idx, BOOL * _Nonnull stop) {
                if (urlQueryKeyValueString.length) {
                    NSRange equalSignRange = [urlQueryKeyValueString rangeOfString:@"="];
                    NSString *key, *value;
                    if (equalSignRange.location == NSNotFound) {
                        key = [urlQueryKeyValueString stringByRemovingPercentEncoding];
                    } else {
                        key = [[urlQueryKeyValueString substringToIndex:equalSignRange.location] stringByRemovingPercentEncoding];
                        value = [[urlQueryKeyValueString substringFromIndex:equalSignRange.location + equalSignRange.length] stringByRemovingPercentEncoding];
                    }
                    
                    urlQueryKeyValues[key] = value ?: @"";
                }
            }];
        }
    }
    
    return urlQueryKeyValues;
}

@end
