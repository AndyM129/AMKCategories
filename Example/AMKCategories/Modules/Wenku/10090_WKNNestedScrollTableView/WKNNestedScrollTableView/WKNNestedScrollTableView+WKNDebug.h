//
//  WKNNestedScrollTableView+WKNDebug.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/18.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableView.h"

@interface UIScrollView (WKNNestedScrollTableViewDebug)

- (nonnull NSString *)wknNestedScrollTableViewDebug_debugDescription;

@end

#pragma mark -

/// Debug Log
#if defined(DEBUG)
#define WKNNestedScrollTableViewLog(fmt, ...) NSLog((@"【WKNNestedScrollTableView】" fmt), ##__VA_ARGS__)
#else
#define WKNNestedScrollTableViewLog(...) {}
#endif
