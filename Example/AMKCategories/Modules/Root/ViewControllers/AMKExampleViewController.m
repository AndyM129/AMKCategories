//
//  AMKExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/10.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleViewController.h"

@interface AMKExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) AMKExampleStackView *exampleStackView;
@property (nonatomic, strong, readwrite, nullable) NSMutableDictionary *params;
@end

@implementation AMKExampleViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype _Nullable)initWithParams:(NSDictionary *_Nullable)params {
    if (self = [self initWithNibName:nil bundle:nil]) {
        self.params = params.mutableCopy;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Example";
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    [self addExamplesIfNeeded];
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

- (AMKExampleStackView *)exampleStackView {
    if (!_exampleStackView) {
        _exampleStackView = [AMKExampleStackView.alloc initWithAxis:UILayoutConstraintAxisVertical spacing:20];
        [self.view addSubview:_exampleStackView];
    }
    return _exampleStackView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)updateViewConstraints {
    [self.exampleStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    [super updateViewConstraints];
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

- (void)addExamplesIfNeeded {
    if (![self isMemberOfClass:AMKExampleViewController.class]) {
        return;
    }
    
    [self.exampleStackView addArrangedTitleLabelWithTitle:@"系统内置字号" customBlock:nil];
    [self.exampleStackView addArrangedLabelWithTitle:@"UIFont.labelFontSize" customBlock:^(UILabel * _Nullable label) {
        label.font = [UIFont systemFontOfSize:UIFont.labelFontSize];
    }];
    [self.exampleStackView addArrangedLabelWithTitle:@"UIFont.buttonFontSize" customBlock:^(UILabel * _Nullable label) {
        label.font = [UIFont systemFontOfSize:UIFont.buttonFontSize];
    }];
    [self.exampleStackView addArrangedLabelWithTitle:@"UIFont.smallSystemFontSize" customBlock:^(UILabel * _Nullable label) {
        label.font = [UIFont systemFontOfSize:UIFont.smallSystemFontSize];
    }];
    [self.exampleStackView addArrangedLabelWithTitle:@"UIFont.systemFontSize" customBlock:^(UILabel * _Nullable label) {
        label.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    }];
    
    [self.exampleStackView addArrangedSeparatorWithCustomBlock:nil];
    
    [self.exampleStackView addArrangedTitleLabelWithTitle:@"标题 blabla blabla blabla blabla blabla blabla blabla blabla" customBlock:nil];
    [self.exampleStackView addArrangedSubtitleLabelWithTitle:@"描述 blabla blabla blabla blabla blabla blabla blabla blabla" customBlock:nil];
     
    
    [self.exampleStackView addArrangedSubview:({
        UITextField *textField = [UITextField.alloc initWithFrame:CGRectMake(0, 0, 0, 50)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"请输入...";
        textField;
    })];
    [self.exampleStackView addArrangedSubview:({
        UIButton *button = [UIButton.alloc initWithFrame:CGRectMake(0, 0, 0, 50)];
        button.layer.cornerRadius = 8;
        button.layer.masksToBounds = YES;
        [button setBackgroundImage:[UIImage imageWithColor:button.tintColor] forState:UIControlStateNormal];
        [button setTitle:@"按钮" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *button) {
            NSInteger clickedTimes = [button.currentTitle componentsSeparatedByString:@"："].lastObject.integerValue;
            [button setTitle:[NSString stringWithFormat:@"按钮 点击次数：%ld", clickedTimes + 1] forState:UIControlStateNormal];
        }];
        button;
    })];
}

@end
