//
//  AMKStackViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/7/8.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKStackViewController.h"

@interface AMKStackViewController ()
@property (nonatomic, strong, readwrite, nullable) AMKStackView *stackView;
@end

@implementation AMKStackViewController

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIViewController amk_pushViewController:self.new animated:YES];
    });
}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
    
    __weak __typeof__(self)weakSelf = self;
    
    // 示例1
    [self.stackView addArrangedSeparatorWithTitle:@"直接用 UIPasteboard 粘贴" color:nil size:12];
    [self.stackView addArrangedSubview:({
        UITextField *textField = [UITextField.alloc init];
        textField.tag = 1;
        textField.height = 40;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField;
    })];
    [self.stackView addArrangedButton:@"UIPasteboard - 粘贴" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        UITextField *textField = [weakSelf.view viewWithTag:1];
        textField.text = [UIPasteboard.generalPasteboard string];
    }];
    
    // 示例2
    if (@available(iOS 16.0, *)) {
        [self.stackView addArrangedSeparatorWithTitle:nil color:UIColor.clearColor size:60];
        [self.stackView addArrangedSeparatorWithTitle:@"通过 UIPasteControl 粘贴" color:nil size:12];
        [self.stackView addArrangedSubview:({
            UITextField *textField = [UITextField.alloc init];
            textField.tag = 2;
            textField.height = 40;
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField;
        })];
        [self.stackView addArrangedSubview:({
            UIPasteControlConfiguration *configuration = [UIPasteControlConfiguration.alloc init];
            //configuration.baseBackgroundColor = UIColor.orangeColor;
            //configuration.baseForegroundColor = UIColor.redColor;
            //configuration.cornerStyle = UIButtonConfigurationCornerStyleCapsule;
            //configuration.displayMode = UIPasteControlDisplayModeIconAndLabel;
            UIPasteControl *pasteControl = [UIPasteControl.alloc initWithConfiguration:configuration];
            pasteControl.target = [weakSelf.view viewWithTag:2];
            pasteControl.height = 40;
            pasteControl;
        })];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Getters & Setters

- (AMKStackView *)stackView {
    if (!_stackView) {
        _stackView = [AMKStackView.alloc initWithAxis:UILayoutConstraintAxisVertical spacing:20];
        [self.view addSubview:_stackView];
        [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
    }
    return _stackView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
