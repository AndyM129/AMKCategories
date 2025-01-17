//
//  AMKExampleStackView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/10.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleStackView.h"
#import <Masonry/Masonry.h>

static void *kArrangedSubviewsKVOContext = &kArrangedSubviewsKVOContext;

@interface AMKExampleStackView ()
@property (nonatomic, strong, readwrite, nullable) UIView *contentView;
@property (nonatomic, assign, readwrite) UIEdgeInsets contentViewInset;
@property (nonatomic, strong, readwrite, nullable) NSMutableArray<__kindof UIView *> *mutableArrangedSubviews;
@end

@implementation AMKExampleStackView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithAxis:(UILayoutConstraintAxis)axis spacing:(CGFloat)spacing {
    if (self = [self initWithFrame:CGRectZero]) {
        self.axis = axis;
        self.spacing = spacing;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.axis = UILayoutConstraintAxisVertical;
    }
    return self;
}

#pragma mark - Getters & Setters

- (void)setAxis:(UILayoutConstraintAxis)axis {
    if (axis == UILayoutConstraintAxisHorizontal) {
        NSAssert(NO, @"目前暂仅支持 UILayoutConstraintAxisVertical，不支持 UILayoutConstraintAxisHorizontal");
        return;
    }
    _axis = axis;
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    self.contentViewInset = contentInset;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView.alloc init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (NSMutableArray<__kindof UIView *> *)mutableArrangedSubviews {
    if (!_mutableArrangedSubviews) {
        _mutableArrangedSubviews = @[].mutableCopy;
    }
    return _mutableArrangedSubviews;
}

- (NSArray<__kindof UIView *> *)arrangedSubviews {
    return self.mutableArrangedSubviews;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)addArrangedSubview:(UIView *)view {
    // 若视图不存在，则直接返回
    if (!view) return;
    
    // 若已加入管理，则直接返回
    if ([self.arrangedSubviews containsObject:view]) return;
    
    // 添加视图，并加入管理
    [self.contentView addSubview:view];
    [self.mutableArrangedSubviews addObject:view];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)removeArrangedSubview:(UIView *)view {
    // 若视图不存在，则直接返回
    if (!view) return;
    
    // 若不是子视图，则直接返回
    if (view.superview != self.contentView) return;
    
    // 移除视图，更新管理
    [view removeFromSuperview];
    [self.mutableArrangedSubviews removeObject:view];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)insertArrangedSubview:(UIView *)view atIndex:(NSUInteger)stackIndex {
    // 若视图不存在，则直接返回
    if (!view) return;
    
    // 若不是子视图，则添加为子视图，并更新管理
    if (view.superview != self.contentView) {
        [self.contentView addSubview:view];
        [self.mutableArrangedSubviews insertObject:view atIndex:MIN(self.arrangedSubviews.count, stackIndex)];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    // 否则已是子视图，则调整位置，并更新管理
    else {
        // 若更新后位置不变，则直接返回
        NSUInteger fromIndex = [self.arrangedSubviews indexOfObject:view];
        NSUInteger toIndex = MIN(self.arrangedSubviews.count, stackIndex);
        if (fromIndex == toIndex) return;
        
        // 先用 NSNull.null 占位，再插入视图，再移除占位的 NSNull.null，最后更新管理
        [self.mutableArrangedSubviews replaceObjectAtIndex:fromIndex withObject:(id)NSNull.null];
        [self.mutableArrangedSubviews insertObject:view atIndex:toIndex];
        [self.mutableArrangedSubviews removeObjectAtIndex:fromIndex];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
    }];
    
    NSArray<UIView *> *subviews = self.arrangedSubviews;
    if (self.axis == UILayoutConstraintAxisHorizontal) {
//        [subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
//            [subview mas_remakeConstraints:^(MASConstraintMaker *make) {
//                if (idx == 0) {
//                    make.left.mas_equalTo(self.contentView).insets(self.contentInset);
//                } else {
//                    make.left.mas_equalTo(subviews[idx-1].mas_right).offset(self.spacing);
//                }
//                make.width.mas_equalTo(subview.width);
//                make.top.bottom.mas_equalTo(self.contentView).insets(self.contentInset);
//            }];
//        }];
    } else {
        [subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
            [subview mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (idx == 0) {
                    make.top.mas_equalTo(self.contentView).inset(self.contentViewInset.top);
                } else {
                    make.top.mas_equalTo(subviews[idx-1].mas_bottom).offset(self.spacing);
                }
                if (subview.height > 0) {
                    make.height.mas_equalTo(subview.height);
                }
                if (idx == subviews.count - 1) {
                    make.bottom.equalTo(self.contentView.mas_bottom).inset(self.contentViewInset.bottom);
                }
                make.left.mas_equalTo(self.contentView).inset(self.contentViewInset.left);
                make.right.mas_equalTo(self.contentView).inset(self.contentViewInset.right);
            }];
        }];
    }
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Overrides

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    return view==self ? nil : view;
}

#pragma mark - Helper Methods

@end
