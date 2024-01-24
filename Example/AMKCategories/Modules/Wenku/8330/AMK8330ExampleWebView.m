//
//  AMK8330ExampleWebView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/12/27.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMK8330ExampleWebView.h"

@implementation AMK8330ExampleWebView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    BOOL canPerform = [super canPerformAction:action withSender:sender];
    if (canPerform) {
        canPerform =
        action == @selector(copy:) ||
        action == @selector(cut:) ||
        action == @selector(paste:) ||
        action == @selector(select:) ||
        action == @selector(selectAll:) ||
        action == @selector(didClickCustomMenuItem:);
    }
    return canPerform;
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
