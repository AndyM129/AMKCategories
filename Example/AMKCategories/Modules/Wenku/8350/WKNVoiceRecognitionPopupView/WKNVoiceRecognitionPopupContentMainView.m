//
//  WKNVoiceRecognitionPopupContentMainView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/29.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionPopupContentMainView.h"

@interface WKNVoiceRecognitionPopupContentMainView ()
@property (nonatomic, strong, readwrite, nullable) UIView *textViewContainer;
@property (nonatomic, strong, readwrite, nullable) UITextView *textView;
@property (nonatomic, strong, readwrite, nullable) UIButton *tipsButton;
@property (nonatomic, strong, readwrite, nullable) UIButton *voiceRecognitionButton;
@end

@implementation WKNVoiceRecognitionPopupContentMainView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

#pragma mark - Getters & Setters

- (UIView *)textViewContainer {
    if (!_textViewContainer) {
        _textViewContainer = [UIView.alloc init];
        _textViewContainer.layer.cornerRadius = 15;
        _textViewContainer.layer.backgroundColor = UIColor.whiteColor.CGColor;
        [self addSubview:_textViewContainer];
    }
    return _textViewContainer;
}

- (UIButton *)tipsButton {
    if (!_tipsButton) {
        _tipsButton = [UIButton.alloc init];
        _tipsButton.userInteractionEnabled = NO;
        _tipsButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        [_tipsButton setTitle:@"松手发送 上滑取消" forState:UIControlStateNormal];
        [_tipsButton setTitle:@"松手取消" forState:UIControlStateNormal];
        [_tipsButton setTitleColor:[UIColor colorWithRed:105/255.0 green:124/255.0 blue:178/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_tipsButton setTitleColor:[UIColor colorWithRed:249/255.0 green:90/255.0 blue:101/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [self addSubview:_tipsButton];
    }
    return _tipsButton;
}

- (UIButton *)voiceRecognitionButton {
    if (!_voiceRecognitionButton) {
        _voiceRecognitionButton = [UIButton.alloc init];
        _voiceRecognitionButton.userInteractionEnabled = NO;
        _voiceRecognitionButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _voiceRecognitionButton.imageEdgeInsets = UIEdgeInsetsMake(18, 0, 0, 0);
        [_voiceRecognitionButton setImage:[UIImage imageNamed:@"wkn_voice_recognition_popup_voice_n"] forState:UIControlStateNormal];
        [_voiceRecognitionButton setImage:[UIImage imageNamed:@"wkn_voice_recognition_popup_voice_h"] forState:UIControlStateHighlighted];
        [_voiceRecognitionButton setBackgroundImage:[UIImage imageNamed:@"wkn_voice_recognition_popup_voice_bg_n"] forState:UIControlStateNormal];
        [_voiceRecognitionButton setBackgroundImage:[UIImage imageNamed:@"wkn_voice_recognition_popup_voice_bg_h"] forState:UIControlStateHighlighted];
        [self addSubview:_voiceRecognitionButton];
    }
    return _voiceRecognitionButton;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (UIEdgeInsets)margin {
    static UIEdgeInsets _margin = {74, 0, 0, 0};
    return _margin;
}

+ (UIEdgeInsets)textViewContainerMargin {
    static UIEdgeInsets _textViewContainerMargin = {10, 17, 160, 17};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _textViewContainerMargin.bottom += UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;
    });
    return _textViewContainerMargin;
}

+ (UIEdgeInsets)textViewMargin {
    static UIEdgeInsets _textViewMargin = {14, 17, 14, 17};
    return _textViewMargin;
}

+ (CGFloat)textViewMinHeight {
    static CGFloat _textViewMinHeight;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat textViewContainerMinHeight = 63;
        _textViewMinHeight = textViewContainerMinHeight - self.class.textViewMargin.top - self.class.textViewMargin.bottom;
    });
    return _textViewMinHeight;
}

+ (CGFloat)textViewMaxHeight {
    static CGFloat _textViewMaxHeight;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat textViewContainerMaxHeight = 176;
        _textViewMaxHeight = textViewContainerMaxHeight - self.class.textViewMargin.top - self.class.textViewMargin.bottom;
    });
    return _textViewMaxHeight;
}

//- (CGFloat)preferredHeightWithoutText {
//    static CGFloat _preferredHeightWhenEmpty = 0;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _preferredHeightWhenEmpty = [self preferredHeightWithText:NO];
//    });
//    return _preferredHeightWhenEmpty;
//}

- (CGFloat)preferredHeight {
    return [self preferredHeightWithText:YES];
}

- (CGFloat)preferredHeightWithText:(BOOL)withText {
    UIEdgeInsets textViewContainerMargin = self.class.textViewContainerMargin;
    UIEdgeInsets textViewMargin = self.class.textViewMargin;
    CGFloat textViewHeight = 0;
//    if (!withText || !self.textView.text.length) {
//        textViewHeight = self.class.textViewMinHeight;
//    } else {
        CGFloat textHeight = self.textView.contentSize.height;
        textViewHeight = MAX(self.class.textViewMinHeight, MIN(self.class.textViewMaxHeight, textHeight));
//    }
    CGFloat preferredHeight = textViewContainerMargin.top + textViewMargin.top + textViewHeight + textViewMargin.bottom + textViewContainerMargin.bottom;
    return preferredHeight;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self customLayoutSubviews];
    [super updateConstraints];
}

- (void)customLayoutSubviews {
//    UIEdgeInsets safeAreaInsets = UIApplication.sharedApplication.delegate.window.safeAreaInsets;
    self.height = self.preferredHeight;
    self.textViewContainer.frame = ({
        CGRect frame = CGRectZero;
        frame.size.width = self.width - self.class.textViewContainerMargin.left - self.class.textViewContainerMargin.right;
        frame.size.height = self.height - self.class.textViewContainerMargin.top - self.class.textViewContainerMargin.bottom;
        frame.origin.x = self.class.textViewContainerMargin.left;
        frame.origin.y = self.class.textViewContainerMargin.top;
        frame;
    });
    self.tipsButton.frame = ({
        CGRect frame = CGRectZero;
        frame.size.width = self.width - self.class.textViewContainerMargin.left - self.class.textViewContainerMargin.right;
        frame.size.height = 13;
        frame.origin.x = self.class.textViewContainerMargin.left;
        frame.origin.y = self.textViewContainer.bottom + 53;
        frame;
    });
    self.voiceRecognitionButton.frame = ({
        CGRect frame = CGRectZero;
        frame.size.width = self.width;
        frame.size.height = self.width / (414 / 103.0);
        frame.origin.x = 0;
        frame.origin.y = self.textViewContainer.bottom + 85;
        frame;
    });
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
