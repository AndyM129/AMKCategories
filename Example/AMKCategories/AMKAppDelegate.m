//
//  AMKAppDelegate.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 07/26/2019.
//  Copyright (c) 2019 AndyM129. All rights reserved.
//

#import "AMKAppDelegate.h"
#import <AMKCategories/UIWindow+AMKReleaseMode.h>

@implementation AMKAppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    [UINavigationBar.appearance setTranslucent:NO];
    [UINavigationBar.appearance setTintColor:self.window.tintColor];
    [UINavigationBar.appearance setBarTintColor:self.window.tintColor];
    [UINavigationBar.appearance setBackgroundColor:UIColor.whiteColor];
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [UINavigationBarAppearance.alloc init];
        appperance.backgroundColor = UINavigationBar.appearance.backgroundColor;
        appperance.shadowImage = [UIImage.alloc init];
        appperance.shadowColor = nil;
        UINavigationBar.appearance.standardAppearance = appperance;
        UINavigationBar.appearance.scrollEdgeAppearance = appperance;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [application amk_showAlertIfMobileProvisionWillExpireInDays:999];
//    [application setAmk_releaseModeCornerMarkEnable:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
