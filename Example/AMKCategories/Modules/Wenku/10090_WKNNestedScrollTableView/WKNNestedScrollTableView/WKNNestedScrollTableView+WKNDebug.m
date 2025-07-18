//
//  WKNNestedScrollTableView+WKNDebug.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/18.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableView+WKNDebug.h"

@implementation UIScrollView (WKNNestedScrollTableViewDebug)

- (nonnull NSString *)wknNestedScrollTableViewDebug_debugDescription {
    NSMutableString *debugDescription = @"".mutableCopy;
    [debugDescription appendFormat:@"<"];
    [debugDescription appendFormat:@"%@: %p", NSStringFromClass(self.class), self];
    [debugDescription appendFormat:@"; baseClass = %@", NSStringFromClass(self.superclass)];
    [debugDescription appendFormat:@"; frame = (%g %g; %g %g)", self.origin.x, self.origin.y, self.size.width, self.size.height];
    [debugDescription appendFormat:@"; contentOffset = (%g %g)", self.contentOffset.x, self.contentOffset.y];
    [debugDescription appendFormat:@"; contentSize = (%g %g)", self.contentSize.width, self.contentSize.height];
    [debugDescription appendFormat:@">"];
    return debugDescription;
}

@end
