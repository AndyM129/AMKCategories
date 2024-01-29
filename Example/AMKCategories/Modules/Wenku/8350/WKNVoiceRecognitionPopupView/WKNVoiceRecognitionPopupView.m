//
//  WKNVoiceRecognitionPopupView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionPopupView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface WKNVoiceRecognitionPopupView ()
@property (nonatomic, strong, readwrite, nullable) CAGradientLayer *contentViewLayerMaskRadientLayer;
@property (nonatomic, strong, readwrite, nullable) WKNVoiceRecognitionPopupContentMainView *contentMainView;
@property (nonatomic, assign, readwrite) WKNVoiceRecognitionPopupViewState state;
@end

@implementation WKNVoiceRecognitionPopupView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:UIScreen.mainScreen.bounds]) {
        self.animationDuration = 0.3;
        self.maskView.hidden = YES;
    }
    return self;
}

#pragma mark - Getters & Setters

+ (WKNVoiceRecognitionPopupView *)sharedInstance {
    static WKNVoiceRecognitionPopupView *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [WKNVoiceRecognitionPopupView.alloc init];
    });
    return _sharedInstance;
}

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
                contentView.alpha = 0;
                [UIView animateWithDuration:duration animations:^{
                    contentView.alpha = 1;
                } completion:nil];
                
                weakSelf.contentMainView.alpha = 0;
                weakSelf.contentMainView.transform = CGAffineTransformMakeTranslation(0, weakSelf.contentMainView.height / 2);
                [UIView animateWithDuration:duration delay:duration / 2 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    weakSelf.contentMainView.alpha = 1;
                    weakSelf.contentMainView.transform = CGAffineTransformIdentity;
                } completion:nil];
            } else {
                [UIView animateWithDuration:duration animations:^{
                    contentView.alpha = 0;
                    weakSelf.contentMainView.alpha = 0;
                    weakSelf.contentMainView.transform = CGAffineTransformMakeTranslation(0, weakSelf.contentMainView.height / 2);
                } completion:^(BOOL finished) {
                    weakSelf.contentMainView.alpha = 0;
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
        CGRect frame = CGRectZero;
        frame.origin.x = WKNVoiceRecognitionPopupContentMainView.margin.left;
        frame.origin.y = WKNVoiceRecognitionPopupContentMainView.margin.top;
        frame.size.width = self.width - WKNVoiceRecognitionPopupContentMainView.margin.left - WKNVoiceRecognitionPopupContentMainView.margin.right;
        
        _contentMainView = [WKNVoiceRecognitionPopupContentMainView.alloc initWithFrame:frame];
        [self.contentView addSubview:_contentMainView];
    }
    return _contentMainView;
}

- (void)setState:(WKNVoiceRecognitionPopupViewState)state {
    [self setState:state animated:NO];
}

- (void)setState:(WKNVoiceRecognitionPopupViewState)state animated:(BOOL)animated {
    if (_state != state) {
        _state = state;
        if (state == WKNVoiceRecognitionPopupViewStateTouchDown) {
            self.contentMainView.tipsButton.highlighted = NO;
            self.contentMainView.voiceRecognitionButton.highlighted = NO;
            [self showInView:self.superview animated:animated];
        } else if (state == WKNVoiceRecognitionPopupViewStateTouchUp) {
            [self dismissAnimated:animated];
        } else if (state == WKNVoiceRecognitionPopupViewStateTouchDragInside) {
            self.contentMainView.tipsButton.highlighted = NO;
            self.contentMainView.voiceRecognitionButton.highlighted = NO;
            AudioServicesPlaySystemSound(1519);
        } else if (state == WKNVoiceRecognitionPopupViewStateTouchDragOutside) {
            self.contentMainView.tipsButton.highlighted = YES;
            self.contentMainView.voiceRecognitionButton.highlighted = YES;
            AudioServicesPlaySystemSound(1519);
        }
    }
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
    [self.contentMainView customLayoutSubviews];
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
