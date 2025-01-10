//
//  AMKExampleStackView+AMKExampleStackViewConveniences.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/10.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleStackView.h"

@interface AMKExampleStackView (AMKExampleStackViewConveniences)

/// 添加标题
- (UILabel *_Nullable)addArrangedTitleLabelWithTitle:(NSString *_Nullable)title customBlock:(void(^_Nullable)(UILabel *_Nullable titleLabel))customBlock;

/// 添加子标题
- (UILabel *_Nullable)addArrangedSubtitleLabelWithTitle:(NSString *_Nullable)subtitle customBlock:(void(^_Nullable)(UILabel *_Nullable subtitleLabel))customBlock;

/// 添加文本
- (UILabel *_Nullable)addArrangedLabelWithTitle:(NSString *_Nullable)text customBlock:(void(^_Nullable)(UILabel *_Nullable label))customBlock;

/// 添加分割线
- (UIView *_Nullable)addArrangedSeparatorWithCustomBlock:(void(^_Nullable)(UIView *_Nullable separatorView))customBlock;

/// 添加按钮
- (UIButton *_Nullable)addArrangedButton:(NSString *_Nullable)title customBlock:(void(^_Nullable)(UIButton *_Nullable button))customBlock touchUpInsideBlock:(void (^_Nullable)(UIButton *_Nullable button))block;

/// 添加容器视图
- (UIView *_Nullable)addArrangedContainerViewWithCustomBlock:(void(^_Nullable)(UIView *_Nullable containerCiew))customBlock;

@end
