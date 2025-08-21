//
//  AMKColorHuePickerView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorHuePickerView.h"

@interface AMKColorHuePickerView ()
@property (nonatomic, strong, readwrite, nullable) AMKColorHueView *colorHueView;
@property (nonatomic, strong, readwrite, nullable) UIView *thumbView;
@end

@implementation AMKColorHuePickerView


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

- (AMKColorHueView *)colorHueView {
    if (!_colorHueView) {
        _colorHueView = [AMKColorHueView.alloc init];
        [self addSubview:_colorHueView];
    }
    return _colorHueView;
}

- (UIView *)thumbView {
    if (!_thumbView) {
        _thumbView = [UIView.alloc init];
        _thumbView.layer.cornerRadius = self.class.thumbViewDefaultSize / 2.0;
        _thumbView.layer.borderColor = UIColor.whiteColor.CGColor;
        _thumbView.layer.borderWidth = 2;
        _thumbView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        _thumbView.layer.shadowRadius = 3;
        _thumbView.layer.shadowOffset = CGSizeMake(0.f, 1.f);
        _thumbView.layer.shadowOpacity = 1;
        _thumbView.backgroundColor = UIColor.whiteColor;
        [self insertSubview:_thumbView aboveSubview:self.colorHueView];
    }
    return _thumbView;
}

- (void)setColorHue:(CGFloat)colorHue {
    _colorHue = MAX(0, MIN(colorHue, 1));
    _color = [UIColor colorWithHue:_colorHue saturation:1 brightness:1 alpha:1];
    [self updateThumbView];
}

- (void)setColor:(UIColor *)color {
    _colorHue = color ? color.hue : 0;
    _color = color ? color : [UIColor colorWithHue:_colorHue saturation:1 brightness:1 alpha:1];
    [self updateThumbView];
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (CGFloat)colorHueViewDefaultHeight {
    return 5;
}

+ (CGFloat)thumbViewDefaultSize {
    return 15;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateThumbView];
}

- (void)customLayoutSubviews {
    [self.colorHueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self.class.colorHueViewDefaultHeight);
    }];
    [self.thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.class.thumbViewDefaultSize);
        make.centerY.mas_equalTo(self.colorHueView);
        make.centerX.mas_equalTo(self.colorHueView.mas_left).offset(0);
    }];
}

- (void)updateThumbView {
    [self.thumbView setBackgroundColor:self.color];
    [self.thumbView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.colorHueView.mas_left).offset(self.colorHue * self.colorHueView.width);
    }];
}

#pragma mark - Action Methods

- (void)handleTouches:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [touches.anyObject locationInView:self];
    CGFloat offsetX = MAX(self.colorHueView.left, MIN(location.x, self.colorHueView.right));
    //NSLog(@"%.2f ~> [%.2f, %.2f] => %.2f", location.x, self.colorHueView.left, self.colorHueView.right, offsetX);
    
    self.colorHue = offsetX / self.colorHueView.width;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self handleTouches:touches withEvent:event];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
