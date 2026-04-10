//
//  NSString+AMKDate.h
//  AMKCategories
//
//  Created by Meng Xinxin on 2026/4/10.
//

#import <Foundation/Foundation.h>

/// NSDate 相关扩展
@interface NSString (AMKDate)

/// 将字符串，通过格式化，转为 NSDate 对象，具体支持如下case：
///
/// 2014-01-20  // Google
///
/// 2014-01-20 12:24:48
/// 2014-01-20T12:24:48   // Google
/// 2014-01-20 12:24:48.000
/// 2014-01-20T12:24:48.000
///
/// 2014-01-20T12:24:48Z        // Github, Apple
/// 2014-01-20T12:24:48+0800    // Facebook
/// 2014-01-20T12:24:48+12:00   // Google
/// 2014-01-20T12:24:48.000Z
/// 2014-01-20T12:24:48.000+0800
/// 2014-01-20T12:24:48.000+12:00
///
/// Fri Sep 04 00:12:21 +0800 2015 // Weibo, Twitter
/// Fri Sep 04 00:12:21.000 +0800 2015
- (NSDate *_Nullable)amk_date;

@end
