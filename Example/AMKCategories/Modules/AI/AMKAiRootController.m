//
//  AMKAiRootController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/5/24.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMKAiRootController.h"
#import "AMKAiWebViewController.h"

@interface AMKAiRootController ()

@end

@implementation AMKAiRootController

//+ (void)load {
//    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
//        [NSNotificationCenter.defaultCenter removeObserver:token];
//        UIApplication.sharedApplication.delegate.window.rootViewController = AMKAiRootController.new;
//    }];
//}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.tabBar.translucent = NO;
    self.viewControllers = @[
        [AMKAiWebViewController.alloc initWithUrl:@"https://xinghuo.xfyun.cn/desk" title:@"Yiyan"],
        [AMKAiWebViewController.alloc initWithUrl:@"https://yiyan.baidu.com/" title:@"Xinghuo"],
        [AMKAiWebViewController.alloc initWithUrl:@"https://alpha.bito.co/bitoai/" title:@"Bito"],
    ];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
