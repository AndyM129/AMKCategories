//
//  WKNVoiceRecognitionButton.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionButton.h"
#import "WKNVoiceRecognitionPanelView.h"

@interface WKNVoiceRecognitionButton ()
@property (nonatomic, strong, readwrite, nullable) WKNVoiceRecognitionPanelView *voiceRecognitionPanelView;
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
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        [self setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:50/255.0 green:115/255.0 blue:246/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self setBackgroundImage:[self resizableBackgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
        [self setBackgroundImage:[self resizableBackgroundImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(handleTouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
    return self;
}

#pragma mark - Getters & Setters

- (WKNVoiceRecognitionPanelView *)voiceRecognitionPanelView {
    if (!_voiceRecognitionPanelView) {
        _voiceRecognitionPanelView = [WKNVoiceRecognitionPanelView.alloc init];
    }
    return _voiceRecognitionPanelView;
}

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

- (void)handleTouchDown:(id)sender {
    NSLog(@"");
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showVoiceRecognitionPanelView) object:nil];
    [self performSelector:@selector(showVoiceRecognitionPanelView) withObject:nil afterDelay:0.1 inModes:@[NSRunLoopCommonModes]];
}

- (void)handleTouchUp:(id)sender {
    NSLog(@"");
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showVoiceRecognitionPanelView) object:nil];
    [self.voiceRecognitionPanelView removeFromSuperview];
}

- (void)showVoiceRecognitionPanelView {
    NSLog(@"");
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showVoiceRecognitionPanelView) object:nil];
    [self.viewController.view addSubview:self.voiceRecognitionPanelView];
}

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
