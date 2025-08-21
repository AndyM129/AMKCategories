//
//  AMKColorHuePickerView.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/8/21.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKColorHuePickerView.h"

@interface AMKColorHuePickerView ()
@property (nonatomic, strong, readwrite, nullable) AMKColorHueView *hueView;
@property (nonatomic, strong, readwrite, nullable) UIView *thumbView;
@end

@implementation AMKColorHuePickerView


#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _selectedHue = 0;
        _selectedColor = [UIColor colorWithHue:_selectedHue saturation:1 brightness:1 alpha:1];
        [self customLayoutSubviews];
    }
    return self;
}

#pragma mark - Getters & Setters

- (AMKColorHueView *)hueView {
    if (!_hueView) {
        _hueView = [AMKColorHueView.alloc init];
        [self addSubview:_hueView];
    }
    return _hueView;
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
        [self insertSubview:_thumbView aboveSubview:self.hueView];
    }
    return _thumbView;
}

- (void)setSelectedHue:(CGFloat)trackingHue {
    if (_selectedHue == trackingHue) {
        return;
    }
    
    _selectedHue = MAX(0, MIN(trackingHue, 1));
    _selectedColor = nil;
    [self updateThumbView];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (UIColor *)selectedColor {
    if (!_selectedColor) {
        _selectedColor = [UIColor colorWithHue:_selectedHue saturation:1 brightness:1 alpha:1];
    }
    return _selectedColor;
}

@synthesize selectedColor = _selectedColor;
- (void)setSelectedColor:(UIColor *)selectedColor {
    [self setSelectedHue:selectedColor ? selectedColor.hue : 1];
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (CGFloat)hueViewDefaultHeight {
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
    [self.hueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self.class.hueViewDefaultHeight);
    }];
    [self.thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.class.thumbViewDefaultSize);
        make.centerY.mas_equalTo(self.hueView);
        make.centerX.mas_equalTo(self.hueView.mas_left).offset(0);
    }];
}

- (void)updateThumbView {
    [self.thumbView setBackgroundColor:self.selectedColor];
    [self.thumbView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.hueView.mas_left).offset(self.selectedHue * self.hueView.width);
    }];
}

#pragma mark - Action Methods

- (void)handleTouches:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [touches.anyObject locationInView:self];
    CGFloat offsetX = MAX(self.hueView.left, MIN(location.x, self.hueView.right));
    //NSLog(@"%.2f ~> [%.2f, %.2f] => %.2f", location.x, self.colorHueView.left, self.colorHueView.right, offsetX);
    
    self.selectedHue = offsetX / self.hueView.width;
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
