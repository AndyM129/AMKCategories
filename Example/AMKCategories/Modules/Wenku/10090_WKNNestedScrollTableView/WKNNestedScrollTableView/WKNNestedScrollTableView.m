//
//  WKNNestedScrollTableView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableView.h"
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

- (void)preferredProcessNestedScrollTableViewDidScroll:(__kindof UIScrollView *)scrollView {
    WKNNestedScrollTableViewLog(@"🔳 %@", scrollView);
    
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
        
        // 关闭 nestedScrollView 的弹性滚动
        if (nestedScrollView.bounces) {
            nestedScrollView.bounces = NO;
        }
        // 若正在显示 nestedScrollView 且没有滚到底，则固定 tableView 的 contentOffset，让其不动
        if (nestedScrollView.contentOffset.y > 0 && (nestedScrollView.contentOffset.y + nestedScrollView.frame.size.height) < nestedScrollView.contentSize.height) {
            self.contentOffset = CGPointMake(0, nestedScrollTableViewCell.top);
            self.showsVerticalScrollIndicator = NO;
        }
        // 若已经显示了 nestedScrollTableViewCell 之前的 cell，则 nestedScrollView 的 contentOffset 需要重置
        if (self.contentOffset.y < nestedScrollTableViewCell.top) {
            nestedScrollView.contentOffset = CGPointZero;
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

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    BOOL shouldRecognizeSimultaneously = YES;
//    // 一方是 当前 tableView 的 panGestureRecognizer
//    shouldRecognizeSimultaneously = shouldRecognizeSimultaneously && gestureRecognizer == self.panGestureRecognizer;
//    
//    // 另一方是 tableView 中的 WKNNestedScrollTableViewCellProtocol Cell
//    UITableViewCell<WKNNestedScrollTableViewCellProtocol> *otherGestureRecognizerCell = [otherGestureRecognizer.view amk_nextResponderWithClass:UITableViewCell.class];
//    UIScrollView *nestedScrollView = [otherGestureRecognizerCell conformsToProtocol:@protocol(WKNNestedScrollTableViewCellProtocol)] ? otherGestureRecognizerCell.nestedScrollView : nil;
//    shouldRecognizeSimultaneously = shouldRecognizeSimultaneously && [otherGestureRecognizer.view isDescendantOfView:nestedScrollView];
//    
//    WKNNestedScrollTableViewLog(@"%@ 👉%@, 👉%@", (shouldRecognizeSimultaneously ? @"⭕️" : @"🚫"), gestureRecognizer, otherGestureRecognizer);
//    return shouldRecognizeSimultaneously;
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    BOOL shouldRecognizeSimultaneously = YES;
//    
//    // 一方是 当前 tableView 的 panGestureRecognizer
//    shouldRecognizeSimultaneously = shouldRecognizeSimultaneously && gestureRecognizer.view == self;
//    
//    // 另一方是 tableView 中的 WKNNestedScrollTableViewCellProtocol Cell
//    shouldRecognizeSimultaneously = shouldRecognizeSimultaneously && otherGestureRecognizer.view == self;
//    
//    WKNNestedScrollTableViewLog(@"%@ 👉%@, 👉%@", (shouldRecognizeSimultaneously ? @"⭕️" : @"🚫"), gestureRecognizer, otherGestureRecognizer);
//    return shouldRecognizeSimultaneously;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL shouldRecognizeSimultaneously = YES;
    
    // 一方是 当前 tableView 的 panGestureRecognizer
    shouldRecognizeSimultaneously = shouldRecognizeSimultaneously && gestureRecognizer == self.panGestureRecognizer;

    // 另一方是将手势加到 tableView 上的 WKNNestedScrollTableViewCellProtocol Cell 的 nestedScrollView 的 panGestureRecognizer
    UITableViewCell<WKNNestedScrollTableViewCellProtocol> *otherGestureRecognizerNestedScrollTableViewCell = objc_getAssociatedObject(otherGestureRecognizer, kNestedScrollTableViewCellKey);
    shouldRecognizeSimultaneously = shouldRecognizeSimultaneously && otherGestureRecognizerNestedScrollTableViewCell;

    WKNNestedScrollTableViewLog(@"%@ 👉%@, 👉%@", (shouldRecognizeSimultaneously ? @"⭕️" : @"🚫"), gestureRecognizer, otherGestureRecognizer);
    return shouldRecognizeSimultaneously;
}

#pragma mark - Helper Methods

@end
