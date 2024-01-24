//
//  WKNVoiceRecognitionPanelView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionPanelView.h"

@implementation WKNVoiceRecognitionPanelView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (CGSizeEqualToSize(CGSizeZero, frame.size)) {
        frame.size.width = UIScreen.mainScreen.bounds.size.width;
        frame.size.height = 147 + UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;
    }
    if (self = [super initWithFrame:frame]) {
        self.layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:244/255.0 blue:250/255.0 alpha:1.0].CGColor;
        self.layer.borderColor = UIColor.whiteColor.CGColor;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 9;
        self.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
        
        self.layer.shadowColor = [UIColor colorWithRed:0.467 green:0.467 blue:0.467 alpha:0.12].CGColor;
        self.layer.shadowRadius = 10;
        self.layer.shadowOffset = CGSizeMake(0.f, 1.67);
        self.layer.shadowOpacity = 1;
        
        self.alpha = 0.8; // DEBUG
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)customLayoutSubviews {
    self.frame = ({
        CGRect frame = CGRectZero;
        frame.size.width = self.superview.width;
        frame.size.height = 173 + UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;
        frame.origin.x = 0;
        frame.origin.y = self.superview.height - frame.size.height;
        frame;
    });
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview) {
        [self customLayoutSubviews];
    }
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
