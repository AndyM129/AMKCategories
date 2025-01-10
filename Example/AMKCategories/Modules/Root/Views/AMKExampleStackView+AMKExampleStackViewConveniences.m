//
//  AMKExampleStackView+AMKExampleStackViewConveniences.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/10.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleStackView+AMKExampleStackViewConveniences.h"

@implementation AMKExampleStackView (AMKExampleStackViewConveniences)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (UILabel *)addArrangedTitleLabelWithTitle:(NSString *)title customBlock:(void(^)(UILabel *))customBlock {
    UILabel *titleLabel = [UILabel.alloc init];
    titleLabel.backgroundColor = self.backgroundColor ?: self.superview.backgroundColor;
    titleLabel.layer.shadowColor = titleLabel.tintColor.CGColor;
    titleLabel.layer.shadowRadius = 0;
    titleLabel.layer.shadowOffset = CGSizeMake(0.f, 1.0f);
    titleLabel.layer.shadowOpacity = 1;
    titleLabel.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    titleLabel.textColor = titleLabel.tintColor;
    titleLabel.numberOfLines = 0;
    titleLabel.text = title;
    !customBlock ?: customBlock(titleLabel);
    [self addArrangedSubview:titleLabel];
    return titleLabel;
}

- (UILabel *)addArrangedSubtitleLabelWithTitle:(NSString *)subtitle customBlock:(void(^)(UILabel *))customBlock {
    UILabel *subtitleLabel = [UILabel.alloc init];
    subtitleLabel.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    subtitleLabel.textColor = UIColor.lightGrayColor;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.text = subtitle;
    !customBlock ?: customBlock(subtitleLabel);
    [self addArrangedSubview:subtitleLabel];
    return subtitleLabel;
}

- (UILabel *)addArrangedLabelWithTitle:(NSString *)text customBlock:(void(^)(UILabel *))customBlock {
    UILabel *titleLabel = [UILabel.alloc init];
    titleLabel.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    titleLabel.numberOfLines = 0;
    titleLabel.text = text;
    !customBlock ?: customBlock(titleLabel);
    [self addArrangedSubview:titleLabel];
    return titleLabel;
}

- (UIView *_Nullable)addArrangedSeparatorWithCustomBlock:(void(^_Nullable)(UIView *_Nullable separatorView))customBlock {
    UIView *separatorView = [UIView.alloc initWithFrame:CGRectMake(0, 0, 0, 1)];
    separatorView.backgroundColor = [self.tintColor colorWithAlphaComponent:.3];
    !customBlock ?: customBlock(separatorView);
    [self addArrangedSubview:separatorView];
    return separatorView;
}

- (UIButton *_Nullable)addArrangedButton:(NSString *_Nullable)title customBlock:(void(^_Nullable)(UIButton *_Nullable button))customBlock touchUpInsideBlock:(void (^_Nullable)(UIButton *_Nullable button))block {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.height = 40;
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:self.tintColor] forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:block];
    !customBlock ?: customBlock(button);
    [self addArrangedSubview:button];
    return button;
}

- (UIView *_Nullable)addArrangedContainerViewWithCustomBlock:(void(^_Nullable)(UIView *_Nullable containerCiew))customBlock {
    UIView *view = [UIView.alloc init];
    view.layer.borderColor = UIColor.lightGrayColor.CGColor;
    view.layer.borderWidth = 1 / UIScreen.mainScreen.scale;
    !customBlock ?: customBlock(view);
    [self addArrangedSubview:view];
    return view;
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
