//
//  WKNVoiceRecognitionPopupContentMainView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/29.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionPopupContentMainView.h"

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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (CGFloat)preferredHeight {
    return 240;
}

+ (UIEdgeInsets)margin {
    static UIEdgeInsets _margin = {74, 0, 0, 0};
    return _margin;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    // Coding ...
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)customLayoutSubviews {
    
}

//- (void)didMoveToSuperview {
//    [super didMoveToSuperview];
//    
//    if (self.superview) {
//        [CATransaction begin];
//        [CATransaction setDisableActions:YES];
//        [self updateConstraints];
//        [CATransaction commit];
//    }
//}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
