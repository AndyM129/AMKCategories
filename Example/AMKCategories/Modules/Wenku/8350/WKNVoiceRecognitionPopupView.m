//
//  WKNVoiceRecognitionPopupView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionPopupView.h"
#import "WKNVoiceRecognitionPopupContentMainView.h"

@interface WKNVoiceRecognitionPopupView ()
@property (nonatomic, strong, readwrite, nullable) CAGradientLayer *contentViewLayerMaskRadientLayer; //!< 内容的渐变遮罩
@property (nonatomic, strong, readwrite, nullable) WKNVoiceRecognitionPopupContentMainView *contentMainView; //!< 内容主体
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

- (BDEPopupViewContentAnimationBlock)contentViewAnimationBlock {
    if (!_contentViewAnimationBlock) {
        __weak __typeof__(self)weakSelf = self;
        _contentViewAnimationBlock = ^(UIView *contentView, BOOL showAnimation, NSTimeInterval duration) {
            if (showAnimation) {
//                [weakSelf customLayoutSubviews];
                
                contentView.alpha = 0;
                [UIView animateWithDuration:duration animations:^{
                    contentView.alpha = 1;
                } completion:nil];
//                [weakSelf updateConstraints];
//                [weakSelf.contentMainView updateConstraints];
                
                weakSelf.contentMainView.transform = CGAffineTransformMakeTranslation(0, weakSelf.contentMainView.height);
                [UIView animateWithDuration:duration delay:duration / 2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    weakSelf.contentMainView.transform = CGAffineTransformIdentity;
                } completion:nil];
            } else {
                [UIView animateWithDuration:duration animations:^{
                    contentView.alpha = 0;
                    weakSelf.contentMainView.transform = CGAffineTransformMakeTranslation(0, weakSelf.contentMainView.height);
                } completion:^(BOOL finished) {
                    weakSelf.contentMainView.transform = CGAffineTransformIdentity;
                }];
            }
        };
    }
    return _contentViewAnimationBlock;
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

- (WKNVoiceRecognitionPopupContentMainView *)contentMainView {
    if (!_contentMainView) {
        _contentMainView = [WKNVoiceRecognitionPopupContentMainView.alloc init];
        [self.contentView addSubview:_contentMainView];
    }
    return _contentMainView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (CGFloat)preferredContentViewHeight {
    return WKNVoiceRecognitionPopupContentMainView.margin.top + self.contentMainView.preferredHeight + WKNVoiceRecognitionPopupContentMainView.margin.bottom;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self customLayoutSubviews];
    [super updateConstraints];
}

- (void)customLayoutSubviews {
//    [self.contentMainView customLayoutSubviews];
    
    self.contentView.frame = ({
        CGRect frame = CGRectZero;
        frame.size.width = self.width;
        frame.size.height = self.preferredContentViewHeight;
        frame.origin.x = 0;
        frame.origin.y = self.height - frame.size.height;
        frame;
    });
    self.contentViewLayerMaskRadientLayer.frame = self.contentView.bounds;
    self.contentViewLayerMaskRadientLayer.endPoint = CGPointMake(0, WKNVoiceRecognitionPopupContentMainView.margin.top / MAX(1.0, self.contentView.height));
    self.contentMainView.frame = ({
        CGRect frame = CGRectZero;
        frame.size.width = self.contentView.width;
        frame.size.height = self.contentView.height - WKNVoiceRecognitionPopupContentMainView.margin.top - WKNVoiceRecognitionPopupContentMainView.margin.bottom;
        frame.origin.x = 0;
        frame.origin.y = WKNVoiceRecognitionPopupContentMainView.margin.top;
        frame;
    });
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
