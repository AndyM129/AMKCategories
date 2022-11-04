//
//  AMKRefreshHeaderToastView.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/11/4.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKRefreshHeaderToastView.h"

@interface AMKRefreshHeaderToastView ()
@property (nonatomic, strong, readwrite, nullable) UIView *contentView;
@property (nonatomic, strong, readwrite, nullable) UIImageView *imageView;
@property (nonatomic, strong, readwrite, nullable) UILabel *titleLabel;
@end

@implementation AMKRefreshHeaderToastView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
    }
    return self;
}

#pragma mark - Getters & Setters

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView.alloc init];
        _contentView.layer.cornerRadius = 15;
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.backgroundColor = UIColor.whiteColor.CGColor;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView.alloc init];
        _imageView.image = [UIImage imageNamed:@"logo"];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _titleLabel.textColor = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:255/255.0];
        _titleLabel.text = @"已为您推荐了新的内容";
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).inset(12);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.imageView.mas_right).offset(4);
        make.right.mas_equalTo(self.contentView).inset(12);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

#pragma mark - Action Methods

- (void)show:(BOOL)willShow animated:(BOOL)animated completion:(AMKRefreshHeaderToastViewCompletionBlock)completion {
    !CGRectEqualToRect(CGRectZero, self.contentView.frame) ?: [self layoutSubviews];
    !willShow ?: [self.contentView setTransform:CGAffineTransformMakeTranslation(0, self.contentView.frame.size.height/3)];
    [UIView animateWithDuration:(animated ? 0.3 : 0) delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = willShow ? 1 : 0;
        !willShow ?: [self.contentView setTransform:CGAffineTransformIdentity];
    } completion:^(BOOL finished) {
        !completion ?: completion(self);
    }];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
