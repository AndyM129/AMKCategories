//
//  UITableView+AMKTableViewSection.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2025/7/15.
//

#import "UITableView+AMKTableViewSection.h"
#import <objc/runtime.h>

@implementation UITableView (AMKTableViewSection)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

- (NSMutableArray<AMKTableViewSection *> *)amk_sections {
    NSMutableArray<AMKTableViewSection *> *_sections = objc_getAssociatedObject(self, @selector(amk_sections));
    if (!_sections) {
        _sections = [NSMutableArray array];
        objc_setAssociatedObject(self, @selector(amk_sections), _sections, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _sections;
}

- (void)setAmk_sections:(NSMutableArray<AMKTableViewSection *> *)sections {
    NSMutableArray<AMKTableViewSection *> *_sections = objc_getAssociatedObject(self, @selector(amk_sections));
    if (![_sections isEqualToArray:sections]) {
        objc_setAssociatedObject(self, @selector(amk_sections), [sections mutableCopy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (BOOL)amk_isSelectAll {
    return [objc_getAssociatedObject(self, @selector(amk_isSelectAll)) boolValue];
}


- (void)setAmk_selectAll:(BOOL)selectAll {
    objc_setAssociatedObject(self, @selector(amk_isSelectAll), @(selectAll), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (NSIndexSet *)amk_indexesOfSectionsWithIdentifier:(NSString *)identifier {
    return [self.amk_sections indexesOfObjectsPassingTest:^BOOL(AMKTableViewSection * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
        return [section.identifier isEqualToString:identifier];
    }];
}

- (NSArray<AMKTableViewSection *> *)amk_sectionsWithIdentifier:(NSString *)identifier {
    return [self.amk_sections objectsAtIndexes:[self amk_indexesOfSectionsWithIdentifier:identifier]];
}

- (NSArray<AMKTableViewRow *> *)amk_rowsWithIdentifier:(NSString *)identifier {
    __block NSMutableArray<AMKTableViewRow *> *rows = @[].mutableCopy;
    [self.amk_sections enumerateObjectsUsingBlock:^(AMKTableViewSection * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
        [section.rows enumerateObjectsUsingBlock:^(AMKTableViewRow * _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([row.identifier isEqualToString:identifier]) {
                [rows addObject:row];
            }
        }];
    }];
    return rows;
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
