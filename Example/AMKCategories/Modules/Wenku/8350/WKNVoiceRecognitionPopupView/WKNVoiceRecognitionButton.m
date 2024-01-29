//
//  WKNVoiceRecognitionButton.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import "WKNVoiceRecognitionButton.h"
#import "WKNVoiceRecognitionLongPressGestureRecognizer.h"
#import "WKNVoiceRecognitionPopupView.h"

@interface WKNVoiceRecognitionButton ()
@property (nonatomic, strong, readwrite, nullable) UILabel *titleLabel;
@property (nonatomic, strong, readwrite, nullable) WKNVoiceRecognitionLongPressGestureRecognizer *longPressGestureRecognizer;
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
    }
    return self;
}

#pragma mark - Getters & Setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        _titleLabel.text = @"按住说话";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:50/255.0 green:115/255.0 blue:246/255.0 alpha:1.0];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (WKNVoiceRecognitionLongPressGestureRecognizer *)longPressGestureRecognizer {
    if (!_longPressGestureRecognizer) {
        _longPressGestureRecognizer = [WKNVoiceRecognitionLongPressGestureRecognizer.alloc init];
        [self addGestureRecognizer:_longPressGestureRecognizer];
    }
    return _longPressGestureRecognizer;
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

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
