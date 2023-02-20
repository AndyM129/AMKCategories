//
//  NSString+AMKURL.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2023/2/7.
//

#import <Foundation/Foundation.h>

@interface NSString (AMKURL)

/// 将 Query 字符串 `abc=1&xyz=2` 或 URL 字符串 `scheme://host/path?abc=1&xyz=2` 解析为键值对 `{abc=1, xyz=2}`
- (NSMutableDictionary<NSString *, NSString *> *)amk_urlQueryKeyValues;

@end
