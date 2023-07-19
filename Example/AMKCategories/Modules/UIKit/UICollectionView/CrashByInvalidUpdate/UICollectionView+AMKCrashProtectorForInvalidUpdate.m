//
//  UICollectionView+AMKCrashProtectorForInvalidUpdate.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/19.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "UICollectionView+AMKCrashProtectorForInvalidUpdate.h"
#import <AMKCategories/NSObject+AMKMethodSwizzling.h>

@implementation UICollectionView (AMKCrashProtectorForInvalidUpdate)

+ (void)load {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self amk_swizzleInstanceMethod:@selector(reloadItemsAtIndexPaths:) withMethod:@selector(AMKCrashProtector_reloadItemsAtIndexPaths:)];
    });
}

- (void)AMKCrashProtector_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    NSException *exception = nil;
    
    // 若「section 数量不一致」，则直接刷新
    NSInteger oldNumberOfSections = self.numberOfSections;
    NSInteger newNumberOfSections = [self.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)] ? [self.dataSource numberOfSectionsInCollectionView:self] : oldNumberOfSections;
    if (oldNumberOfSections != newNumberOfSections) {
        NSString *reason = [NSString stringWithFormat:@"Invalid update: 当前有 %ld 个 section，但 dataSource 有 %ld 个。Collection view: %@", oldNumberOfSections, newNumberOfSections, self.description];
        exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:@{}];
    }
    // 否则逐个验证「section 的 items 数量是否一致」，只要有不一致的，则直接刷新
    else if (self.dataSource) {
        for (NSInteger section = 0; section < self.numberOfSections; section++) {
            NSInteger oldNumberOfItemsInSection = [self numberOfItemsInSection:section];
            NSInteger newNumberOfItemsInSection = [self.dataSource collectionView:self numberOfItemsInSection:section];
            if (oldNumberOfItemsInSection != newNumberOfItemsInSection) {
                NSString *reason = [NSString stringWithFormat:@"Invalid update: section %ld 当前有 %ld 个 items，但 dataSource 有 %ld 个。Collection view: %@", section, oldNumberOfItemsInSection, newNumberOfItemsInSection, self.description];
                exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:@{}];
                break;
            }
        }
    }
        
    if (exception) {
        @try {
            [exception raise];
        } @catch (NSException *exception) {
            NSString *title = @"CrashProtector";
            NSString *message = [NSString stringWithFormat:@"检测到无效的 indexPath，已整体刷新：%@", exception];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
            [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
            NSLog(@"%@ => %@", exception, exception.userInfo);
        }
        
        [self reloadData];
    } else {
        [self AMKCrashProtector_reloadItemsAtIndexPaths:indexPaths];
    }
}

//- (void)AMKCrashProtector_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
//    BOOL needsReloadData = NO;
//    if (self.numberOfSections != [self.dataSource numberOfSectionsInCollectionView:self]) { // 若「section 数量不一致」，则直接刷新
//        needsReloadData = YES;
//    } else if (self.dataSource) { // 否则逐个验证「待刷新 section 的 items 数量是否一致」，只要有不一致的，则直接刷新
//        for (NSInteger section = 0; section < self.numberOfSections; section++) {
//            NSInteger oldNumberOfItemsInSection = [self numberOfItemsInSection:section];
//            NSInteger newNumberOfItemsInSection = [self.dataSource collectionView:self numberOfItemsInSection:section];
//            if (oldNumberOfItemsInSection != newNumberOfItemsInSection) {
//                needsReloadData = YES;
//                break;
//            }
//        }
//    }
//
//    if (needsReloadData) {
//        [self reloadData];
//
//        NSString *title = @"CrashProtector";
//        NSString *message = [NSString stringWithFormat:@"检测到无效的 indexPath，已整体刷新"];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
//        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
//    } else {
//        [self AMKCrashProtector_reloadItemsAtIndexPaths:indexPaths];
//    }
//}


// 不能只验证「待刷新的 section」
//- (void)AMKCrashProtector_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
//    BOOL needsReloadData = NO;
//    if (self.numberOfSections != [self.dataSource numberOfSectionsInCollectionView:self]) { // 若「section 数量不一致」，则直接刷新
//        needsReloadData = YES;
//    } else if (self.dataSource) { // 否则逐个验证「待刷新 section 的 items 数量是否一致」
//        if (indexPaths.count <= 1) {
//            NSInteger section = indexPaths.firstObject.section;
//            NSInteger oldNumberOfItemsInSection = [self numberOfItemsInSection:section];
//            NSInteger newNumberOfItemsInSection = [self.dataSource collectionView:self numberOfItemsInSection:section];
//            needsReloadData = oldNumberOfItemsInSection != newNumberOfItemsInSection;
//        } else {
//            NSMutableDictionary<NSNumber *, NSNumber *> *cachedNewNumberOfItemsInSection = @{}.mutableCopy;
//            needsReloadData = [indexPaths indexOfObjectPassingTest:^BOOL(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSNumber *section = @(indexPath.section);
//                if (![cachedNewNumberOfItemsInSection containsObjectForKey:section]) {
//                    cachedNewNumberOfItemsInSection[section] = @([self.dataSource collectionView:self numberOfItemsInSection:indexPath.section]);
//                }
//                NSInteger oldNumberOfItemsInSection = [self numberOfItemsInSection:indexPath.section];
//                NSInteger newNumberOfItemsInSection = cachedNewNumberOfItemsInSection[section].integerValue;
//                return oldNumberOfItemsInSection != newNumberOfItemsInSection;
//            }] != NSNotFound;
//        }
//    }
//
//    if (needsReloadData) {
//        [self reloadData];
//
//        NSString *title = @"CrashProtector";
//        NSString *message = [NSString stringWithFormat:@"检测到无效的 indexPath，已整体刷新"];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
//        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
//    } else {
//        [self AMKCrashProtector_reloadItemsAtIndexPaths:indexPaths];
//    }
//}

// 直接通过代理获取最新的数量，然后过滤掉「无效的 indexPaths」，仅刷新「有效的 indexPaths」也不行：局部刷新时，只要「与数据源 item 数量不一致」，就会crash
//- (void)AMKCrashProtector_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
//    NSIndexSet *invalidIndexSet = [indexPaths indexesOfObjectsPassingTest:^BOOL(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
//        return ![self AMKCrashProtector_validatesIndexPath:indexPath];
//    }];
//    if (!invalidIndexSet.count) {
//        [self AMKCrashProtector_reloadItemsAtIndexPaths:indexPaths];
//    } else {
//        NSMutableArray<NSIndexPath *> *validIndexPaths = indexPaths.mutableCopy;
//        [validIndexPaths removeObjectsAtIndexes:invalidIndexSet];
//        [self reloadData];
//
//        NSString *title = @"CrashProtector";
//        NSString *message = [NSString stringWithFormat:@"检测到 %ld 个无效的 indexPath：%@", invalidIndexSet.count, [indexPaths objectsAtIndexes:invalidIndexSet]];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
//        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
//    }
//}
//
//- (BOOL)AMKCrashProtector_validatesIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section >= [self.dataSource numberOfSectionsInCollectionView:self]) {
//        return NO;
//    }
//    if (indexPath.item >= [self.dataSource collectionView:self numberOfItemsInSection:indexPath.section]) {
//        return NO;
//    }
//    return YES;
//}

// 过滤掉「无效的 indexPaths」，仅刷新「有效的 indexPaths」也不行：在 reloadData 之前，直接加减数据源元素，UICollectionView 是无法通过 `-numberOfSections`、`-numberOfItemsInSection:` 知道 item 真正数量的
//- (void)AMKCrashProtector_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
//
//    NSIndexSet *validIndexSet = [indexPaths indexesOfObjectsPassingTest:^BOOL(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
//        return [self AMKCrashProtector_validatesIndexPath:indexPath];
//    }];
//    NSArray<NSIndexPath *> *validIndexPaths = [indexPaths objectsAtIndexes:validIndexSet];
//    [self AMKCrashProtector_reloadItemsAtIndexPaths:validIndexPaths];
//
//    if (validIndexSet.count != ) {
//        NSString *title = @"CrashProtector";
//        NSString *message = exception.reason;
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
//        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
//    }
//}

//- (BOOL)AMKCrashProtector_validatesIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section >= self.numberOfSections) {
//        return NO;
//    }
//    if (indexPath.item >= [self numberOfItemsInSection:indexPath.section]) {
//        return NO;
//    }
//    return YES;
//}

// 捕获异常时，直接 reloadData 无效：虽然不 crash 了，但是 UICollectionView 也无法再刷新UI了
//- (void)AMKCrashProtector_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
//    @try {
//        [self AMKCrashProtector_reloadItemsAtIndexPaths:indexPaths];
//    } @catch (NSException *exception) {
//        NSString *title = @"CrashProtector";
//        NSString *message = exception.reason;
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
//        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
//        //[BDECrashProtectReporter reportCrashWithException:exception];
//
//        [self reloadData];
//        [self setNeedsUpdateConstraints];
//        [self updateConstraintsIfNeeded];
//        [self setNeedsLayout];
//        [self layoutIfNeeded];
//    } @finally {
//
//    }
//}

@end
