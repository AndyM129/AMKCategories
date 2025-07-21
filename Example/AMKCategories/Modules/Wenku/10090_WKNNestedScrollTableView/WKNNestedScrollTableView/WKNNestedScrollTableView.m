//
//  WKNNestedScrollTableView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableView+WKNDebug.h"
#import "WKNNestedScrollTableViewCachedCellProtocol.h"
#import "WKNNestedScrollTableViewCellProtocol.h"
#import <AMKCategories/NSDictionary+AMKObjectForKey.h>
#import <AMKCategories/UIResponder+AMKUIResponderExtensionMethods.h>
#import <objc/runtime.h>

static void *kNestedScrollTableViewCellKey = &kNestedScrollTableViewCellKey;

@interface WKNNestedScrollTableView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong, readwrite, nullable) NSMutableDictionary<id, WKNNestedScrollTableViewCachedCell *> *cachedCells;
@property (nonatomic, strong, readwrite, nullable) NSMutableDictionary<NSString *, Class> *registeredClasses;
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

- (NSMutableDictionary<NSString *,Class> *)registeredClasses {
    if (!_registeredClasses) {
        _registeredClasses = @{}.mutableCopy;
    }
    return _registeredClasses;
}

- (NSMutableDictionary<id,__kindof UITableViewCell *> *)cachedCells {
    if (!_cachedCells) {
        _cachedCells = @{}.mutableCopy;
    }
    return _cachedCells;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)preferredProcessNestedScrollTableViewDidScroll:(__kindof UIScrollView *)tableView {
    if (tableView != self) {
        return;
    }
    
    //CGFloat currentContentOffsetY = self.contentOffset.y; //!< 当前的内容偏移Y
    WKNNestedScrollTableViewLog(@"🔳 %@", self.wknNestedScrollTableViewDebug_debugDescription);
}

- (void)_preferredProcessNestedScrollTableViewDidScroll:(__kindof UIScrollView *)tableView {
    if (tableView != self) {
        return;
    }
    
    static void *kLastContentOffsetYKey = &kLastContentOffsetYKey;
    CGFloat lastContentOffsetY = [objc_getAssociatedObject(self, kLastContentOffsetYKey) floatValue]; //!< 上次的内容偏移Y
    CGFloat currentContentOffsetY = self.contentOffset.y; //!< 当前的内容偏移Y
    CGFloat currentScrollOffsetY = currentContentOffsetY - lastContentOffsetY; //!< 本次 相较于上次，Y的偏移差值
    BOOL isScrollingToDown = currentScrollOffsetY > 0; //!< 是否在向下滚动
    objc_setAssociatedObject(self, kLastContentOffsetYKey, @(self.contentOffset.y), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    WKNNestedScrollTableViewLog(@"🔳 %@ —— ΔY = %g %@", self.wknNestedScrollTableViewDebug_debugDescription, currentScrollOffsetY, (isScrollingToDown ? @"⇣" : @"⇡"));
    
    // 将当前可见的 cell 基于 indexPath 排序
    NSArray<NSIndexPath *> *sortedIndexPathsForVisibleRows = [self.indexPathsForVisibleRows sortedArrayUsingSelector:@selector(compare:)];
    
    // 找到遵守 `WKNNestedScrollTableViewCellProtocol` 协议的 cell，以便后续对其处理
    NSInteger indexForNestedScrollTableViewCell = [sortedIndexPathsForVisibleRows indexOfObjectPassingTest:^BOOL(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        return [cell conformsToProtocol:@protocol(WKNNestedScrollTableViewCellProtocol)];
    }];
    
    // 若有 nestedScrollTableViewCell
    if (indexForNestedScrollTableViewCell != NSNotFound) {
        NSIndexPath *indexPathForNestedScrollTableViewCell = sortedIndexPathsForVisibleRows[indexForNestedScrollTableViewCell];
        UITableViewCell<WKNNestedScrollTableViewCellProtocol> *nestedScrollTableViewCell = [self cellForRowAtIndexPath:indexPathForNestedScrollTableViewCell];
        UIScrollView *nestedScrollView = nestedScrollTableViewCell.nestedScrollView;
        
        // 若 nestedScrollView 开始滚动
        if (nestedScrollView.contentOffset.y > 0) {
            CGFloat nestedScrollViewContentOffsetMaxY = nestedScrollView.contentOffset.y + nestedScrollView.frame.size.height;
            CGFloat nestedScrollViewContentSizeHeight = nestedScrollView.contentSize.height;
            CGFloat nestedScrollTableViewCellTop = nestedScrollTableViewCell.top;
            
            // 若 nestedScrollView 没有滚到底，则固定 tableView 的 contentOffset，让其不动
//            if (!isScrollingToDown) {
//                nestedScrollViewContentOffsetMaxY = ceil(nestedScrollViewContentOffsetMaxY + fabs(currentScrollOffsetY));
//            }
            if (nestedScrollViewContentOffsetMaxY < nestedScrollViewContentSizeHeight) {
                self.contentOffset = CGPointMake(0, nestedScrollTableViewCellTop);
                self.showsVerticalScrollIndicator = NO;

//                if (isScrollingToDown) {
//                    self.contentOffset = CGPointMake(0, nestedScrollTableViewCell.top);
//                    self.showsVerticalScrollIndicator = NO;
//                }
            }
        }
        // 否则 nestedScrollView 没有滚动，恢复 tableView 的正常滚动
        else {
            self.showsVerticalScrollIndicator = YES;
        }
    } else {
        self.showsVerticalScrollIndicator = YES;
    }
}

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
                [self.cachedCells setObject:cell forKey:identifier];
            }
        }
        // 否则，走默认实现
        else {
            cell = [super dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        }
        
        // 若该 Cell 遵守 WKNNestedScrollTableViewCellProtocol 协议，则将其
        if ([cell conformsToProtocol:@protocol(WKNNestedScrollTableViewCellProtocol)]) {
            UITableViewCell<WKNNestedScrollTableViewCellProtocol> *nestedScrollTableViewCell = (id)cell;
            UIScrollView *nestedScrollView = nestedScrollTableViewCell.nestedScrollView;
            nestedScrollView.bounces = NO; // 关闭 nestedScrollView 的弹性滚动
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

    // 另一方是被加到 tableView 上的 WKNNestedScrollTableViewCellProtocol Cell 的 nestedScrollView 的 panGestureRecognizer
    UITableViewCell<WKNNestedScrollTableViewCellProtocol> *otherGestureRecognizerNestedScrollTableViewCell = objc_getAssociatedObject(otherGestureRecognizer, kNestedScrollTableViewCellKey);
    shouldRecognizeSimultaneously = shouldRecognizeSimultaneously && otherGestureRecognizerNestedScrollTableViewCell;

    WKNNestedScrollTableViewLog(@"%@ 👉%@, 👉%@", (shouldRecognizeSimultaneously ? @"⭕️" : @"🚫"), gestureRecognizer, otherGestureRecognizer);
    return shouldRecognizeSimultaneously;
}

#pragma mark - Helper Methods

@end
