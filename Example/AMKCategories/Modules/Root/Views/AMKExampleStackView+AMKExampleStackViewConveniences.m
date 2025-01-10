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

- (UIButton *)addArrangedButton:(NSString *)title controlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block {
    return [self addArrangedButton:title size:40 controlEvents:controlEvents block:block];
}

- (UIButton *)addArrangedButton:(NSString *)title size:(CGFloat)size controlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.axis == UILayoutConstraintAxisHorizontal) {
        button.width = size;
    } else {
        button.height = size;
    }
    button.layer.cornerRadius = 7;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:self.tintColor] forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button addBlockForControlEvents:controlEvents block:block];
    [self addArrangedSubview:button];
    return button;
}

- (UIView *)addArrangedSeparatorWithTitle:(NSString *)title color:(UIColor *)color size:(CGFloat)size {
    UILabel *label = [UILabel.alloc init];
    if (self.axis == UILayoutConstraintAxisHorizontal) {
        label.width = size;
    } else {
        label.height = size;
    }
    label.font = [UIFont boldSystemFontOfSize:size*0.9];
    label.textColor = color ?: self.tintColor;
    label.text = title;
    label.numberOfLines = 0;
    
    UIView *bottomSeparator = [UIView.alloc init];
    bottomSeparator.backgroundColor = color ?: [self.tintColor colorWithAlphaComponent:.3];
    [label addSubview:bottomSeparator];
    [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.axis == UILayoutConstraintAxisHorizontal) {
            make.top.bottom.mas_equalTo(label);
            make.centerX.mas_equalTo(label.mas_right);
            make.width.mas_equalTo(1);
        } else {
            make.left.right.mas_equalTo(label);
            make.centerY.mas_equalTo(label.mas_bottom);
            make.height.mas_equalTo(1);
        }
    }];
    
    [self addArrangedSubview:label];
    return label;
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
