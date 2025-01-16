//
//  AMKXxxExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKXxxExampleViewController.h"

@interface AMKXxxExampleViewController ()

@end

@implementation AMKXxxExampleViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 示例说明
    if (self.viewModel.subtitle.length) {
        [self.exampleStackView addArrangedSubtitleLabelWithTitle:self.viewModel.subtitle customBlock:nil];
    }
    
    // 示例：页面参数
    [self.exampleStackView addArrangedTitleLabelWithTitle:@"页面参数" customBlock:nil];
    [self.exampleStackView addArrangedLabelWithTitle:self.viewModel.pageParams.jsonPrettyStringEncoded ?: @"(无)" customBlock:nil];
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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
