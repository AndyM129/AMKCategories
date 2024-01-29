//
//  WKNVoiceRecognitionButton.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionButton.h"
#import "WKNVoiceRecognitionPopupView.h"

@interface WKNVoiceRecognitionButton ()
@property (nonatomic, strong, readwrite, nullable) UILabel *titleLabel;
@property (nonatomic, strong, readwrite, nullable) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic, strong, readwrite, nullable) WKNVoiceRecognitionPopupView *voiceRecognitionPanelView;
@property (nonatomic, assign, readwrite) WKNVoiceRecognitionButtonState state;
@end

@implementation WKNVoiceRecognitionButton

#pragma mark - Init Methods

- (void)dealloc {
    [self removeObserverBlocks];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.height == 0) {
        frame.size.height = 46;
    }
    if (self = [super initWithFrame:frame]) {
        self.layer.shadowColor = [UIColor colorWithRed:0.467 green:0.467 blue:0.467 alpha:0.12].CGColor;
        self.layer.shadowRadius = 10;
        self.layer.shadowOffset = CGSizeMake(0.f, 1.67);
        self.layer.shadowOpacity = 1;
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.backgroundColor = UIColor.whiteColor.CGColor;
        self.longPressGestureRecognizer.enabled = YES;
        [self customLayoutSubviews];
//        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
//        [self setTitle:@"按住 说话" forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor colorWithRed:50/255.0 green:115/255.0 blue:246/255.0 alpha:1.0] forState:UIControlStateNormal];
//        [self setBackgroundImage:[self resizableBackgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
//        [self setBackgroundImage:[self resizableBackgroundImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
//        [self addTarget:self action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
//        [self addTarget:self action:@selector(handleTouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
    return self;
}

#pragma mark - Getters & Setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        _titleLabel.text = @"按住 说话";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:115/255.0 blue:246/255.0 alpha:1.0];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILongPressGestureRecognizer *)longPressGestureRecognizer {
    if (!_longPressGestureRecognizer) {
        _longPressGestureRecognizer = [UILongPressGestureRecognizer.alloc initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
        _longPressGestureRecognizer.minimumPressDuration = 0.1;
        [self addGestureRecognizer:_longPressGestureRecognizer];
    }
    return _longPressGestureRecognizer;
}

- (WKNVoiceRecognitionPopupView *)voiceRecognitionPanelView {
    if (!_voiceRecognitionPanelView) {
        _voiceRecognitionPanelView = [WKNVoiceRecognitionPopupView.alloc init];
    }
    return _voiceRecognitionPanelView;
}

- (void)setState:(WKNVoiceRecognitionButtonState)state {
    [self setState:state animated:NO];
}

- (void)setState:(WKNVoiceRecognitionButtonState)state animated:(BOOL)animated {
    _state = state;
    if (state == WKNVoiceRecognitionButtonStateTouchDown) {
        [self.voiceRecognitionPanelView showInView:self.voiceRecognitionPanelView.superview animated:animated];
    } else if (state == WKNVoiceRecognitionButtonStateTouchUp) {
        [self.voiceRecognitionPanelView dismissAnimated:animated];
    }
//    [UIView animateWithDuration:animated ? 0.25 : 0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        
//    } completion:^(BOOL finished) {
//        
//    }];
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)customLayoutSubviews {
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
}

#pragma mark - Action Methods

- (void)handleLongPressGestureRecognizer:(id)sender {
    CGPoint location = [self.longPressGestureRecognizer locationInView:self];
    NSLog(@"%ld => %@", self.longPressGestureRecognizer.state, @(location));
    
    switch (self.longPressGestureRecognizer.state) {
        case UIGestureRecognizerStatePossible: {
            
        } break;
        case UIGestureRecognizerStateBegan: {
            [self setState:WKNVoiceRecognitionButtonStateTouchDown animated:YES];
        } break;
        case UIGestureRecognizerStateChanged: {
            
        } break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            [self setState:WKNVoiceRecognitionButtonStateTouchUp animated:YES];
        } break;
        default: {} break;
    }
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
