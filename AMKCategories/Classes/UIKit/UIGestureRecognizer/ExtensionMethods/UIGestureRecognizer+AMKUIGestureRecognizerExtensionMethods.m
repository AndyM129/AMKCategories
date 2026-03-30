//
//  UIGestureRecognizer+AMKUIGestureRecognizerExtensionMethods.m
//  AMKCategories
//
//  Created by Meng Xinxin on 2026/3/27.
//

#import "UIGestureRecognizer+AMKUIGestureRecognizerExtensionMethods.h"

@implementation UIGestureRecognizer (AMKUIGestureRecognizerExtensionMethods)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Public Methods

- (void)amk_cancelsTouches {
    if (self.isEnabled) {
        self.enabled = NO;
        self.enabled = YES;
    }
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
