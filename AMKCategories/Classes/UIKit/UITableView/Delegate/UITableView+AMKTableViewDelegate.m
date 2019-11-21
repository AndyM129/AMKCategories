//
//  UITableView+AMKTableViewDelegate.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2019/11/21.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import "UITableView+AMKTableViewDelegate.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@interface UITableView (AMKTableViewDelegate)

@end

@implementation UITableView (AMKTableViewDelegate)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UITableView amk_swizzleInstanceMethod:@selector(reloadData) withMethod:@selector(AMKTableViewDelegate_UITableView_reloadData)];
    });
}

#pragma mark - Init Methods

#pragma mark - Properties

#pragma mark - Layout Subviews

#pragma mark - Public Methods

- (void)AMKTableViewDelegate_UITableView_reloadData {
    [self AMKTableViewDelegate_UITableView_delegatePerformSelector:@selector(amk_tableViewWillReloadData:) withObject:self];
    [self AMKTableViewDelegate_UITableView_reloadData];
    [self AMKTableViewDelegate_UITableView_delegatePerformSelector:@selector(amk_tableViewDidReloadData:) withObject:self];
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

- (BOOL)AMKTableViewDelegate_UITableView_delegatePerformSelector:(SEL)aSelector withObject:(id)anArgument {
    if (!self.delegate) return NO;
    if (![self.delegate conformsToProtocol:@protocol(AMKTableViewDelegate)]) return NO;
    if (![self.delegate respondsToSelector:aSelector]) return NO;
    
#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.delegate performSelector:aSelector withObject:anArgument];
#   pragma clang diagnostic pop
    return YES;
}

@end
