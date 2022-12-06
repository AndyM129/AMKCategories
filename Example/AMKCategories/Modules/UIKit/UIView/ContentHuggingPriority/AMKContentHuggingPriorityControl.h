//
//  AMKContentHuggingPriorityControl.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/6/7.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMKContentHuggingPriorityControl : UIControl
@property (nonatomic, strong, readwrite, nullable) UILabel *label;
@property (nonatomic, strong, readwrite, nullable) UITextField *textField;
@property (nonatomic, strong, readwrite, nullable) UISlider *slider;

@property (nonatomic, strong, readwrite, nullable) UILabel *contentHuggingPriorityLabel;
@property (nonatomic, strong, readwrite, nullable) UISegmentedControl *contentHuggingPrioritySegmentedControl;

@property (nonatomic, strong, readwrite, nullable) UILabel *contentCompressionResistancePriorityLabel;
@property (nonatomic, strong, readwrite, nullable) UISegmentedControl *contentCompressionResistancePrioritySegmentedControl;
@end
