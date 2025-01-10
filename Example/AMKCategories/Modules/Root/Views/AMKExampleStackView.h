//
//  AMKExampleStackView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/10.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 类似 UIStackView
@interface AMKExampleStackView : UIView

/// 布局被管理的子视图的主轴
@property (nonatomic, assign, readwrite) UILayoutConstraintAxis axis;

/// 布局被管理的子视图的间距
@property (nonatomic, assign, readwrite) CGFloat spacing;

/// 布局被管理的子视图的内边距，默认 UIEdgeInsetsZero
@property (nonatomic, assign, readwrite) UIEdgeInsets contentInset;

/// 所有被管理的子视图
@property (nonatomic, copy, readonly, nullable) NSArray<__kindof UIView *> *arrangedSubviews;

/// 初始化
- (instancetype _Nullable)initWithAxis:(UILayoutConstraintAxis)axis spacing:(CGFloat)spacing;

/// 添加子视图
- (void)addArrangedSubview:(UIView *_Nullable)view;

/// 移除子视图
- (void)removeArrangedSubview:(UIView *_Nullable)view;

/// 插入子视图
- (void)insertArrangedSubview:(UIView *_Nullable)view atIndex:(NSUInteger)stackIndex;

@end
