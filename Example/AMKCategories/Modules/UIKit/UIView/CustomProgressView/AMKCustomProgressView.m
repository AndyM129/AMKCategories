//
//  AMKCustomProgressView.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/7/8.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKCustomProgressView.h"

@interface AMKCustomProgressView ()
@property (nonatomic, strong, readwrite, nullable) UIView *contentView; // 容器视图
@property (nonatomic, strong, readwrite, nullable) UIImageView *progressImageView;
@end

@implementation AMKCustomProgressView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:140/255.0 blue:79/255.0 alpha:118/255.0];
    }
    return self;
}

#pragma mark - Getters & Setters

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView.alloc init];
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIImageView *)progressImageView {
    if (!_progressImageView) {
        _progressImageView = [UIImageView.alloc init];
        [self.contentView addSubview:_progressImageView];
    }
    return _progressImageView;
}

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    _progress = progress;
    [UIView animateWithDuration:0.2 animations:^{
        [self.progressImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.contentView).multipliedBy(self.progress < 1 ? self.progress : 1.3);
        }];
        [self.contentView layoutSubviews];
    }];
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentEdgeInsets);
    }];
    [self.progressImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(self.progressImageView.image.size.height * -1.5);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

#pragma mark - Public Methods


#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
