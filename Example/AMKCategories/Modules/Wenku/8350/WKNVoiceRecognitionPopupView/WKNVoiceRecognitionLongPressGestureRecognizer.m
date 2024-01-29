//
//  WKNVoiceRecognitionLongPressGestureRecognizer.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/29.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionLongPressGestureRecognizer.h"
#import "WKNVoiceRecognitionPopupView.h"

@interface WKNVoiceRecognitionPopupView (WKNVoiceRecognitionLongPressGestureRecognizer)
- (void)setState:(WKNVoiceRecognitionPopupViewState)state;
- (void)setState:(WKNVoiceRecognitionPopupViewState)state animated:(BOOL)animated;
@end

#pragma mark -

@implementation WKNVoiceRecognitionLongPressGestureRecognizer

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if (self = [super initWithTarget:self action:@selector(handleVoiceRecognitionLongPressGestureRecognizer:)]) {
        self.minimumPressDuration = 0.1;
        if (target && action) {
            [self addTarget:target action:action];
        }
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Public Methods

- (void)handleVoiceRecognitionLongPressGestureRecognizer:(id)sender {
    switch (self.state) {
        case UIGestureRecognizerStatePossible: {
            
        } break;
        case UIGestureRecognizerStateBegan: {
            [WKNVoiceRecognitionPopupView.sharedInstance setState:WKNVoiceRecognitionPopupViewStateTouchDown animated:YES];
        } break;
        case UIGestureRecognizerStateChanged: {
            CGPoint location = [self locationInView:WKNVoiceRecognitionPopupView.sharedInstance.contentMainView];
            if (CGRectContainsPoint(WKNVoiceRecognitionPopupView.sharedInstance.contentMainView.voiceRecognitionButton.frame, location)) {
                [WKNVoiceRecognitionPopupView.sharedInstance setState:WKNVoiceRecognitionPopupViewStateTouchDragInside animated:YES];
            } else {
                [WKNVoiceRecognitionPopupView.sharedInstance setState:WKNVoiceRecognitionPopupViewStateTouchDragOutside animated:YES];
            }
        } break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            [WKNVoiceRecognitionPopupView.sharedInstance setState:WKNVoiceRecognitionPopupViewStateTouchUp animated:YES];
        } break;
        default: {} break;
    }
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
