//
//  AMKContentHuggingPriorityControl.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/6/7.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKContentHuggingPriorityControl.h"

NSString *string = @"文字文字文字文字文字文字文字文字文字文字文字文字文字文字";

@implementation AMKContentHuggingPriorityControl

#pragma mark - Init Methods

- (void)dealloc {
    [_textField removeObserverBlocks];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textField.text = string;
    }
    return self;
}

#pragma mark - Getters & Setters

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel.alloc init];
    }
    return _label;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField.alloc init];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_textField];
        
        __weak __typeof__(self)weakSelf = self;
        [_textField addObserverBlockForKeyPath:@"text" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
            weakSelf.label.text = newVal;
        }];
    }
    return _textField;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [UISlider.alloc init];
        _slider.maximumValue = string.length;
        _slider.minimumValue = 0;
        _slider.value = _slider.maximumValue;
        [self addSubview:_slider];

        __weak __typeof__(self)weakSelf = self;
        [_slider addBlockForControlEvents:UIControlEventValueChanged block:^(UISlider *slider) {
            weakSelf.textField.text = [string substringToIndex:slider.value];
        }];
    }
    return _slider;
}

- (UILabel *)contentHuggingPriorityLabel {
    if (!_contentHuggingPriorityLabel) {
        _contentHuggingPriorityLabel = [UILabel.alloc init];
        _contentHuggingPriorityLabel.font = [UIFont systemFontOfSize:10];
        _contentHuggingPriorityLabel.text = @"Hugging:";
        [self addSubview:_contentHuggingPriorityLabel];
    }
    return _contentHuggingPriorityLabel;
}

- (UISegmentedControl *)contentHuggingPrioritySegmentedControl {
    if (!_contentHuggingPrioritySegmentedControl) {
        NSArray<NSNumber *> *kContentHuggingPriorities = @[@(UILayoutPriorityDefaultLow), @(UILayoutPriorityDefaultHigh), @(UILayoutPriorityRequired)];
        NSArray<NSNumber *> *kContentHuggingPriorityTitles = @[@"Low", @"High", @"Required"];
        
        _contentHuggingPrioritySegmentedControl = [UISegmentedControl.alloc initWithItems:kContentHuggingPriorityTitles];
        [self addSubview:_contentHuggingPrioritySegmentedControl];
        
        __weak __typeof__(self)weakSelf = self;
        [_contentHuggingPrioritySegmentedControl addBlockForControlEvents:UIControlEventValueChanged block:^(UISegmentedControl *segmentedControl) {
            UILayoutPriority priority = kContentHuggingPriorities[segmentedControl.selectedSegmentIndex].floatValue;
            [weakSelf.label setContentHuggingPriority:priority forAxis:UILayoutConstraintAxisHorizontal];
        }];
    }
    return _contentHuggingPrioritySegmentedControl;
}

- (UILabel *)contentCompressionResistancePriorityLabel {
    if (!_contentCompressionResistancePriorityLabel) {
        _contentCompressionResistancePriorityLabel = [UILabel.alloc init];
        _contentCompressionResistancePriorityLabel.font = [UIFont systemFontOfSize:10];
        _contentCompressionResistancePriorityLabel.text = @"CompressionResistance:";
        [self addSubview:_contentCompressionResistancePriorityLabel];
    }
    return _contentCompressionResistancePriorityLabel;
}

- (UISegmentedControl *)contentCompressionResistancePrioritySegmentedControl {
    if (!_contentCompressionResistancePrioritySegmentedControl) {
        NSArray<NSNumber *> *kContentCompressionResistancePriorities = @[@(UILayoutPriorityDefaultLow), @(UILayoutPriorityDefaultHigh), @(UILayoutPriorityRequired)];
        NSArray<NSNumber *> *kContentCompressionResistancePriorityTitles = @[@"Low", @"High", @"Required"];
        
        _contentCompressionResistancePrioritySegmentedControl = [UISegmentedControl.alloc initWithItems:kContentCompressionResistancePriorityTitles];
        [self addSubview:_contentCompressionResistancePrioritySegmentedControl];
        
        __weak __typeof__(self)weakSelf = self;
        [_contentCompressionResistancePrioritySegmentedControl addBlockForControlEvents:UIControlEventValueChanged block:^(UISegmentedControl *segmentedControl) {
            UILayoutPriority priority = kContentCompressionResistancePriorities[segmentedControl.selectedSegmentIndex].floatValue;
            [weakSelf.label setContentCompressionResistancePriority:priority forAxis:UILayoutConstraintAxisHorizontal];
            weakSelf.label.text = weakSelf.textField.text;
        }];
    }
    return _contentCompressionResistancePrioritySegmentedControl;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(0);
    }];
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.textField.mas_bottom).offset(10);
    }];
    
    [self.contentHuggingPriorityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(160);
        make.top.bottom.mas_equalTo(self.contentHuggingPrioritySegmentedControl);
    }];
    [self.contentHuggingPrioritySegmentedControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentHuggingPriorityLabel.mas_right);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.slider.mas_bottom).offset(10);
    }];
    
    [self.contentCompressionResistancePriorityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(160);
        make.top.bottom.mas_equalTo(self.contentCompressionResistancePrioritySegmentedControl);
    }];
    [self.contentCompressionResistancePrioritySegmentedControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentCompressionResistancePriorityLabel.mas_right);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.contentHuggingPrioritySegmentedControl.mas_bottom).offset(10);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Overrides

#pragma mark - Helper Methods

@end
