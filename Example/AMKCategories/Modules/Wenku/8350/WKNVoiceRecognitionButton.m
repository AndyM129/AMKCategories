//
//  WKNVoiceRecognitionButton.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionButton.h"

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
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        [self setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:50/255.0 green:115/255.0 blue:246/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self setBackgroundImage:[self resizableBackgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
        [self setBackgroundImage:[self resizableBackgroundImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    // Coding ...
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

- (UIImage *)resizableBackgroundImageForState:(UIControlState)state {
    UIColor *color = state == UIControlStateHighlighted ? [UIColor colorWithWhite:0.85 alpha:1] : UIColor.whiteColor;
    CGFloat radius = self.frame.size.height / 2;
    CGSize size = CGSizeMake(self.frame.size.height, self.frame.size.height);
    UIImage *backgroundImage = [UIImage imageWithColor:color size:size];
    backgroundImage = [backgroundImage imageByRoundCornerRadius:radius];
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius) resizingMode:UIImageResizingModeStretch];
    return backgroundImage;
}

@end
