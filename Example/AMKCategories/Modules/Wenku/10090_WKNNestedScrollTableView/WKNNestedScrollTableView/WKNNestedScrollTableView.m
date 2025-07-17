//
//  WKNNestedScrollTableView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "WKNNestedScrollTableView.h"
#import <AMKCategories/NSDictionary+AMKObjectForKey.h>

@interface WKNNestedScrollTableView ()
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
    
    // 若 webViewTableViewCell 可见
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

- (nullable __kindof UITableViewCell *)cachedCellForIdentifier:(nullable NSString *)identifier atIndexPath:(nullable NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (identifier.length) {
        cell = [self.cachedCells amk_objectForKey:identifier asClass:UITableViewCell.class];
        if (!cell) {
            if (!indexPath) {
                Class cellClass = self.registeredClasses[identifier];
                cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            } else {
                cell = [self dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            }
            [self.cachedCells setObject:cell forKey:identifier];
        }
    }
    return cell;
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
