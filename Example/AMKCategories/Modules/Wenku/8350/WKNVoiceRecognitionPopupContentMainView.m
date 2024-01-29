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
@property (nonatomic, strong, readwrite, nullable) UIButton *voiceRecognitionButton;
@end

@implementation WKNVoiceRecognitionPopupContentMainView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 1;
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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (UIEdgeInsets)margin {
    static UIEdgeInsets _margin = {74, 0, 0, 0};
    return _margin;
}

+ (UIEdgeInsets)textViewContainerMargin {
    static UIEdgeInsets _textViewContainerMargin = {10, 17, 154, 17};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _textViewContainerMargin.bottom += UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;
    });
    return _textViewContainerMargin;
}

//+ (UIEdgeInsets)textViewMargin {
//    static UIEdgeInsets _textViewMargin = {7, 49, 7, 15};
//    return _textViewMargin;
//}

//+ (CGFloat)textViewMinHeight {
//    static CGFloat _textViewMinHeight;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        CGFloat textViewContainerMinHeight = 47;
//        _textViewMinHeight = textViewContainerMinHeight - WKNAigcChatInputView.textViewMargin.top - WKNAigcChatInputView.textViewMargin.bottom;
//    });
//    return _textViewMinHeight;
//}

//+ (CGFloat)textViewMaxHeight {
//    static CGFloat _textViewMaxHeight;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        CGFloat textViewContainerMaxHeight = 176 + 14;
//        _textViewMaxHeight = textViewContainerMaxHeight - WKNAigcChatInputView.textViewMargin.top - WKNAigcChatInputView.textViewMargin.bottom;
//    });
//    return _textViewMaxHeight;
//}

- (CGFloat)preferredHeightWithoutText {
    static CGFloat _preferredHeightWhenEmpty = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _preferredHeightWhenEmpty = [self preferredHeightWithText:NO];
    });
    return _preferredHeightWhenEmpty;
}

- (CGFloat)preferredHeight {
    return [self preferredHeightWithText:YES];
}

- (CGFloat)preferredHeightWithText:(BOOL)withText {
//    UIEdgeInsets textViewContainerMargin = WKNAigcChatInputView.textViewContainerMargin;
//    UIEdgeInsets textViewMargin = WKNAigcChatInputView.textViewMargin;
//    CGFloat textViewHeight = 0;
//    if (!withText || !self.textView.text.length) {
//        textViewHeight = WKNAigcChatInputView.textViewMinHeight;
//    } else {
//        CGFloat textHeight = self.textView.contentSize.height;
//        CGFloat minTextHeight = MAX(WKNAigcChatInputView.textViewMinHeight, textHeight);
//        textViewHeight = MIN(WKNAigcChatInputView.textViewMaxHeight, minTextHeight);
//    }
//    CGFloat tagsViewHeight = 0;
//    if (!self.tagsView.isEmpty) {
//        tagsViewHeight = self.tagsView.customContentSize.height;
//    }
//    
//    CGFloat preferredHeight = textViewContainerMargin.top + textViewMargin.top + textViewHeight + textViewMargin.bottom + textViewContainerMargin.bottom + tagsViewHeight;
//    return preferredHeight;
    return 240;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self customLayoutSubviews];
    [super updateConstraints];
}

- (void)customLayoutSubviews {
    self.height = self.preferredHeight;
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
