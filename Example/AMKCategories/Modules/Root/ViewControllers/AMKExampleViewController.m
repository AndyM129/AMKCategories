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
        _exampleStackView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
        [self.view addSubview:_exampleStackView];
    }
    return _exampleStackView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

- (void)updateViewConstraints {
    [self.exampleStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
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
    
    [self.exampleStackView addArrangedSubtitleLabelWithTitle:@"组件介绍 blabla blabla blabla blabla blabla blabla blabla blabla" customBlock:nil];
    
    [self.exampleStackView addArrangedTitleLabelWithTitle:@"系统内置字号" customBlock:nil];
    [self.exampleStackView addArrangedLabelWithTitle:[NSString stringWithFormat:@"UIFont.buttonFontSize = %.2f", UIFont.buttonFontSize] customBlock:^(UILabel * _Nullable label) {
        label.font = [UIFont systemFontOfSize:UIFont.buttonFontSize];
    }];
    [self.exampleStackView addArrangedLabelWithTitle:[NSString stringWithFormat:@"UIFont.labelFontSize = %.2f", UIFont.labelFontSize] customBlock:^(UILabel * _Nullable label) {
        label.font = [UIFont systemFontOfSize:UIFont.labelFontSize];
    }];
    [self.exampleStackView addArrangedLabelWithTitle:[NSString stringWithFormat:@"UIFont.systemFontSize = %2f", UIFont.systemFontSize] customBlock:^(UILabel * _Nullable label) {
        label.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    }];
    [self.exampleStackView addArrangedLabelWithTitle:[NSString stringWithFormat:@"UIFont.smallSystemFontSize = %2f", UIFont.smallSystemFontSize] customBlock:^(UILabel * _Nullable label) {
        label.font = [UIFont systemFontOfSize:UIFont.smallSystemFontSize];
    }];
    
    [self.exampleStackView addArrangedTitleLabelWithTitle:@"标题 blabla blabla blabla blabla blabla blabla blabla blabla" customBlock:nil];
    [self.exampleStackView addArrangedSubtitleLabelWithTitle:@"子标题 blabla blabla blabla blabla blabla blabla blabla blabla" customBlock:nil];
    
    [self.exampleStackView addArrangedSubview:({
        UITextField *textField = [UITextField.alloc initWithFrame:CGRectMake(0, 0, 0, 50)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"请输入...";
        textField;
    })];
    [self.exampleStackView addArrangedButton:@"按钮" customBlock:nil touchUpInsideBlock:^(UIButton * _Nullable button) {
        NSInteger clickedTimes = [button.currentTitle componentsSeparatedByString:@"："].lastObject.integerValue;
        [button setTitle:[NSString stringWithFormat:@"按钮 点击次数：%ld", clickedTimes + 1] forState:UIControlStateNormal];
    }];
    
    [self.exampleStackView addArrangedSeparatorWithCustomBlock:nil];
    [self.exampleStackView addArrangedContainerViewWithCustomBlock:^(UIView * _Nullable containerCiew) {
        containerCiew.height = 100;
        containerCiew.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:.15];
    }];
    [self.exampleStackView addArrangedContainerViewWithCustomBlock:^(UIView * _Nullable containerCiew) {
        UIView *subview = [UIView.alloc init];
        subview.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.5];
        
        [containerCiew addSubview:subview];
        [subview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(150);
            make.left.top.mas_equalTo(containerCiew).inset(20);
            make.bottom.mas_equalTo(containerCiew).inset(50);
        }];
    }];
}

@end
