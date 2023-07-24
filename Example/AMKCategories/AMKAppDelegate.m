//
//  AMKAppDelegate.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 07/26/2019.
//  Copyright (c) 2019 AndyM129. All rights reserved.
//

#import "AMKAppDelegate.h"
#import "AMKRootViewController.h"
#import <AMKCategories/UIWindow+AMKReleaseMode.h>
#import <FLEX/FLEX.h>

@implementation AMKAppDelegate

#pragma mark - Life Circle

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    [self setupAppearanceOfNavigationBar];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [UIWindow.alloc initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [UINavigationController.alloc initWithRootViewController:AMKRootViewController.new];
    [self.window makeKeyAndVisible];
    //    [application amk_showAlertIfMobileProvisionWillExpireInDays:999];
    //    [application setAmk_releaseModeCornerMarkEnable:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FLEXManager.sharedManager showExplorer];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

/// 设置「导航栏」UI样式
- (void)setupAppearanceOfNavigationBar {
    [UINavigationBar.appearance setTranslucent:NO];
    [UINavigationBar.appearance setTintColor:UIColor.blackColor];
    [UINavigationBar.appearance setBarTintColor:UIColor.orangeColor];
    [UINavigationBar.appearance setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName: UIColor.blackColor}];
    [UINavigationBar.appearance setBackgroundColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
    [UINavigationBar.appearance setPrefersLargeTitles:NO];
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [UINavigationBarAppearance.alloc init];
        appperance.backgroundColor = UINavigationBar.appearance.backgroundColor;
        appperance.titleTextAttributes = UINavigationBar.appearance.titleTextAttributes;
        UINavigationBar.appearance.standardAppearance = appperance;
        UINavigationBar.appearance.scrollEdgeAppearance = appperance;
    }
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end

#pragma mark -
#pragma mark -

#if __has_include(<LookinServer/LookinServer.h>)

@implementation NSObject (LookinConfig)

+ (BOOL)lookin_shouldCaptureImageOfView:(UIView *)view {
    NSArray *noShowViews = @[
        NSClassFromString(@"FLEXWindow"),
    ];
    return [noShowViews containsObject:view.class] ? NO : YES;
}

@end

#endif
