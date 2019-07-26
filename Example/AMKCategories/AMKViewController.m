//
//  AMKViewController.m
//  AMKCategories
//
//  Created by AndyM129 on 07/26/2019.
//  Copyright (c) 2019 AndyM129. All rights reserved.
//

#import "AMKViewController.h"

@interface AMKViewController ()

@end

@implementation AMKViewController

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Class DemoViewController = NSClassFromString(@"AMKAppVersionInfoViewController");
    Class DemoViewController = NSClassFromString(@"AMKGitCommitInfoViewController");
    [self.navigationController pushViewController:DemoViewController.new animated:YES];
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

#pragma mark - Properties

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
