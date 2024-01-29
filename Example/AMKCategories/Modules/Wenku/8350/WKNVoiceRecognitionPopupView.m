//
//  WKNVoiceRecognitionPopupView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionPopupView.h"

@interface WKNVoiceRecognitionPopupView ()
@property (nonatomic, strong, readwrite, nullable) CAGradientLayer *contentViewLayerMaskRadientLayer;
@end

@implementation WKNVoiceRecognitionPopupView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:UIScreen.mainScreen.bounds]) {
        self.animationDuration = 0.25;
        self.maskView.hidden = YES;
        self.alpha = 0.9; // DEBUG
    }
    return self;
}

#pragma mark - Getters & Setters

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView.alloc init];
        _contentView.layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:244/255.0 blue:250/255.0 alpha:1.0].CGColor;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (void)setContentView:(UIImageView *)contentView {
    NSAssert(NO, @"自定义页面，请勿赋值");
}

- (CAGradientLayer *)contentViewLayerMaskRadientLayer {
    if (!_contentViewLayerMaskRadientLayer) {
        _contentViewLayerMaskRadientLayer = [CAGradientLayer layer];
        _contentViewLayerMaskRadientLayer.colors = @[
            (__bridge id)[UIColor colorWithWhite:1 alpha:0].CGColor,
            (__bridge id)[UIColor colorWithWhite:1 alpha:1].CGColor
        ];
        _contentViewLayerMaskRadientLayer.startPoint = CGPointMake(0, 0);
        self.contentView.layer.mask = _contentViewLayerMaskRadientLayer;
    }
    return _contentViewLayerMaskRadientLayer;
}

- (BDEPopupViewContentAnimationBlock)contentViewAnimationBlock {
    if (!_contentViewAnimationBlock) {
        __weak __typeof__(self)weakSelf = self;
        _contentViewAnimationBlock = ^(UIView *contentView, BOOL showAnimation, NSTimeInterval duration) {
            if (showAnimation) {
                [weakSelf customLayoutSubviews];
                contentView.alpha = 0;
                [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    contentView.alpha = 1;
                } completion:nil];
            } else {
                [UIView animateWithDuration:duration animations:^{
                    contentView.alpha = 0;
                }];
            }
        };
    }
    return _contentViewAnimationBlock;
}

- (BDEPopupViewContentAnimationBlock)maskViewAnimationBlock {
    if (!_maskViewAnimationBlock) {
        _maskViewAnimationBlock = ^(UIView *maskView, BOOL showAnimation, NSTimeInterval duration) {};
    }
    return _maskViewAnimationBlock;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (UIEdgeInsets)contentViewPadding {
    static UIEdgeInsets _contentViewPadding;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _contentViewPadding = UIEdgeInsetsMake(74, 0, UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom, 0);
    });
    return _contentViewPadding;
}

- (CGFloat)preferredHeight {
    return self.class.contentViewPadding.top + 240 + self.class.contentViewPadding.bottom;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self customLayoutSubviews];
    [super updateConstraints];
}

- (void)customLayoutSubviews {
    self.contentView.frame = ({
        CGRect frame = CGRectZero;
        frame.size.width = self.width;
        frame.size.height = self.preferredHeight;
        frame.origin.x = 0;
        frame.origin.y = self.height - frame.size.height;
        frame;
    });
    self.contentViewLayerMaskRadientLayer.frame = self.contentView.bounds;
    self.contentViewLayerMaskRadientLayer.endPoint = CGPointMake(0, self.class.contentViewPadding.top / MAX(1.0, self.contentView.height));
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if (self.superview) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [self updateConstraints];
        [CATransaction commit];
    }
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
