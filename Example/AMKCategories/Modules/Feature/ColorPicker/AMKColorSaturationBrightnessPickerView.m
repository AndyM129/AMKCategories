//
//  AMKColorSaturationBrightnessPickerView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorSaturationBrightnessPickerView.h"

@interface AMKColorSaturationBrightnessPickerView ()
@property (nonatomic, strong, readwrite, nullable) AMKColorSaturationBrightnessView *saturationBrightnessView;
@property (nonatomic, strong, readwrite, nullable) UIImageView *cursorView;
@end

@implementation AMKColorSaturationBrightnessPickerView

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customLayoutSubviews];
    }
    return self;
}

#pragma mark - Getters & Setters

- (AMKColorSaturationBrightnessView *)saturationBrightnessView {
    if (!_saturationBrightnessView) {
        __weak __typeof__(self)weakSelf = self;
        _saturationBrightnessView = [AMKColorSaturationBrightnessView.alloc init];
        [_saturationBrightnessView addBlockForControlEvents:UIControlEventValueChanged block:^(id  _Nonnull sender) {
            [weakSelf updateCursorView];
        }];
        [self addSubview:_saturationBrightnessView];
    }
    return _saturationBrightnessView;
}

- (UIImageView *)cursorView {
    if (!_cursorView) {
        UIImage *image = [UIImage systemImageNamed:@"plus" withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:15]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _cursorView = [UIImageView.alloc init];
        _cursorView.tintColor = [UIColor colorWithWhite:0.85 alpha:1];
        _cursorView.image = image;
        [self addSubview:_cursorView];
    }
    return _cursorView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateCursorView];
}

- (void)customLayoutSubviews {
    [self.saturationBrightnessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self updateCursorView];
}

- (void)updateCursorView {
    CGRect cursorViewFrame = CGRectZero;
    cursorViewFrame.size = !CGSizeEqualToSize(CGSizeZero, self.cursorView.size) ? self.cursorView.size : self.cursorView.image.size;
    cursorViewFrame.origin.x = self.saturationBrightnessView.left + self.saturationBrightnessView.width * self.saturationBrightnessView.saturation - cursorViewFrame.size.width / 2;
    cursorViewFrame.origin.y = self.saturationBrightnessView.top + self.saturationBrightnessView.height * (1 - self.saturationBrightnessView.brightness) - cursorViewFrame.size.height / 2;
    self.cursorView.frame = cursorViewFrame;
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
