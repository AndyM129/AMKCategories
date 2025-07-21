//
//  WKNNestedScrollTableView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableView+WKNDebug.h"
#import "WKNNestedScrollTableViewCell.h"
#import "WKNNestedScrollTableViewCachedCellProtocol.h"
#import <AMKCategories/NSDictionary+AMKObjectForKey.h>
#import <AMKCategories/UIResponder+AMKUIResponderExtensionMethods.h>
#import <objc/runtime.h>

static void *kNestedScrollTableViewCellKey = &kNestedScrollTableViewCellKey;

@interface WKNNestedScrollTableView () <UIGestureRecognizerDelegate>

/// 当前已通过 `-registerClass:forCellReuseIdentifier:` 注册过的类
@property (nonatomic, strong, readwrite, nullable) NSMutableDictionary<NSString *, Class> *registeredClasses;

/// 当前已缓存的 Cell
@property (nonatomic, strong, readwrite, nullable) NSMutableDictionary<WKNNestedScrollTableViewCacheKey *, WKNNestedScrollTableViewCachedCell *> *cachedCells;

@end

@implementation WKNNestedScrollTableView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
    }
    return self;
}

#pragma mark - Getters & Setters

- (NSMutableDictionary<NSString *, Class> *)registeredClasses {
    if (!_registeredClasses) {
        _registeredClasses = @{}.mutableCopy;
    }
    return _registeredClasses;
}

- (NSMutableDictionary<WKNNestedScrollTableViewCacheKey *, WKNNestedScrollTableViewCachedCell *> *)cachedCells {
    if (!_cachedCells) {
        _cachedCells = @{}.mutableCopy;
    }
    return _cachedCells;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [super registerClass:cellClass forCellReuseIdentifier:identifier];
    [self.registeredClasses setObject:cellClass forKey:identifier];
}

- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;

    if (identifier.length) {
        // 读取该 identifier 所注册的类
        Class cellClass = self.registeredClasses[identifier];
        
        // 若该类 遵守缓存协议
        if ([cellClass conformsToProtocol:@protocol(WKNNestedScrollTableViewCachedCellProtocol)]) {
            
            // 优先从 `cachedCells` 中读取
            cell = [self.cachedCells amk_objectForKey:identifier asClass:UITableViewCell.class];
            
            // 若没有，则先初始化 并添加缓存
            if (!cell) {
                if (!indexPath) {
                    cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                } else {
                    cell = [super dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
                }
                [self.cachedCells setObject:(WKNNestedScrollTableViewCachedCell *)cell forKey:identifier];
            }
        }
        // 否则，走默认实现
        else {
            cell = [super dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        }
        
        // 若为 WKNNestedScrollTableViewCell，且有 nestedScrollView，则将其 panGestureRecognizer 添加到当前 tableView，以便接管其滑动手势
        if ([cell isKindOfClass:WKNNestedScrollTableViewCell.class] && [(WKNNestedScrollTableViewCell *)cell nestedScrollView]) {
            WKNNestedScrollTableViewCell *nestedScrollTableViewCell = (id)cell;
            UIScrollView *nestedScrollView = nestedScrollTableViewCell.nestedScrollView;
            nestedScrollView.bounces = NO; // 关闭 nestedScrollView 的弹性滚动
            nestedScrollView.showsVerticalScrollIndicator = NO; // 关闭 nestedScrollView 的竖向滚动条
            objc_setAssociatedObject(nestedScrollView.panGestureRecognizer, kNestedScrollTableViewCellKey, nestedScrollTableViewCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self addGestureRecognizer:nestedScrollView.panGestureRecognizer];
        }
    }
    
    return cell;
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL shouldRecognizeSimultaneously = YES;
    
    // 一方是 当前 tableView 的 panGestureRecognizer
    shouldRecognizeSimultaneously = shouldRecognizeSimultaneously && gestureRecognizer == self.panGestureRecognizer;

    // 另一方是被加到 tableView 上的 WKNNestedScrollTableViewCell 的 nestedScrollView 的 panGestureRecognizer
    WKNNestedScrollTableViewCell *otherGestureRecognizerNestedScrollTableViewCell = objc_getAssociatedObject(otherGestureRecognizer, kNestedScrollTableViewCellKey);
    shouldRecognizeSimultaneously = shouldRecognizeSimultaneously && otherGestureRecognizerNestedScrollTableViewCell;

    WKNNestedScrollTableViewLog(@"%@ 👉%@, 👉%@", (shouldRecognizeSimultaneously ? @"⭕️" : @"🚫"), gestureRecognizer, otherGestureRecognizer);
    return shouldRecognizeSimultaneously;
}

#pragma mark - Helper Methods

@end
