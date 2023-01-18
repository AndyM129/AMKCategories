//
//  AMKLifeCircleTabBarBaseViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/12/29.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKLifeCircleTabBarBaseViewController.h"
#import "AMKLifeCircleTabBarSubViewController.h"

@interface AMKLifeCircleTabBarBaseViewController ()

@end

@implementation AMKLifeCircleTabBarBaseViewController

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
    self.navigationItem.leftBarButtonItems = @[
        [UIBarButtonItem.alloc initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(amk_goBack)],
        [UIBarButtonItem.alloc initWithTitle:@"PresentFromRoot" style:UIBarButtonItemStylePlain target:self action:@selector(presentNextViewControllerFromRoot:)],
    ];
    self.navigationItem.rightBarButtonItems = @[
        [UIBarButtonItem.alloc initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextViewController:)],
        [UIBarButtonItem.alloc initWithTitle:@"Present" style:UIBarButtonItemStylePlain target:self action:@selector(presentNextViewController:)]
    ];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
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

- (void)pushNextViewController:(id)sender {
    [UIViewController amk_gotoViewController:self.nextViewController transitionStyle:AMKViewControllerTransitionStylePush animated:YES];
}

- (void)presentNextViewController:(id)sender {
    [UIViewController amk_gotoViewController:self.nextViewController transitionStyle:AMKViewControllerTransitionStylePresent animated:YES];
}

- (void)presentNextViewControllerFromRoot:(id)sender {
    UINavigationController *navigationController = [UINavigationController.alloc initWithRootViewController:self.nextViewController];
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:navigationController animated:YES completion:nil];
}

- (UIViewController *)nextViewController {
    AMKLifeCircleTabBarSubViewController *viewController = [AMKLifeCircleTabBarSubViewController.alloc init];
    viewController.amk_presentedWithNavigationController = YES;
    return viewController;
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
