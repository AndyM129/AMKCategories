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
    NSLog(@"🔳 %@", scrollView);
    
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
        
        // 若正在显示 nestedScrollView，则固定 tableView 的 contentOffset，让其不动
        if (nestedScrollView.contentOffset.y > 0) {
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
    
    
//    // 若 webViewTableViewCell 可见
//    if (self.webViewTableViewCell && !self.webViewTableViewCell.isHidden && self.webViewTableViewCell.alpha>0) {
//        // 正在显示 webViewTableViewCell 中的 webView，则固定 tableView 的 contentOffset，让其不动
//        if (self.webViewTableViewCell.webView.scrollView.contentOffset.y > 0) {
//            self.contentOffset = CGPointMake(0, self.webViewTableViewCell.top);
//            self.showsVerticalScrollIndicator = NO;
//        }
//        // 已经显示了 tableView 中 webViewTableViewCell 之前的 cell，则 webViewTableViewCell 中的 webView 的 contentOffset 需要重置
//        if (self.contentOffset.y < self.webViewTableViewCell.top) {
//            self.webViewTableViewCell.webView.scrollView.contentOffset = CGPointZero;
//            self.showsVerticalScrollIndicator = YES;
//        }
//    } else {
//        self.showsVerticalScrollIndicator = YES;
//    }
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
    }
    
    return cell;
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIPanGestureRecognizer.class] && [otherGestureRecognizer isKindOfClass:UIPanGestureRecognizer.class];
}

#pragma mark - Helper Methods

@end
