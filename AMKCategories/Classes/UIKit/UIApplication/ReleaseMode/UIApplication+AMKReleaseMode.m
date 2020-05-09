//
//  UIApplication+AMKReleaseMode.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/9.
//

#import "UIApplication+AMKReleaseMode.h"
#import <AMKCategories/NSBundle+AMKMobileProvision.h>

NSString * AMKStringFromApplicationReleaseMode(AMKUIApplicationReleaseMode releaseMode) {
    NSString *localizedReleaseModeString = nil;
    switch (releaseMode) {
        case AMKUIApplicationReleaseModeSim: localizedReleaseModeString = @"Simulator"; break;
        case AMKUIApplicationReleaseModeAdHoc: localizedReleaseModeString = @"AdHoc"; break;
        case AMKUIApplicationReleaseModeDev: localizedReleaseModeString = @"Development"; break;
        case AMKUIApplicationReleaseModeAppStore: localizedReleaseModeString = @"AppStore"; break;
        case AMKUIApplicationReleaseModeEnterprise: localizedReleaseModeString = @"Enterprise"; break;
        default: localizedReleaseModeString = @"Unknow"; break;
    }
    return localizedReleaseModeString;
}

@implementation UIApplication (AMKReleaseMode)

#pragma mark - Init Methods

#pragma mark - Properties

// 参考：https://github.com/amazon-archives/BSMobileProvision
- (AMKUIApplicationReleaseMode)amk_releaseMode {
    static AMKUIApplicationReleaseMode releaseMode = AMKUIApplicationReleaseModeUnknown;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *mobileProvisionInfoDictionary = [NSBundle.mainBundle amk_mobileProvisionInfoDictionary];
        if (!mobileProvisionInfoDictionary) {
            // failure to read other than it simply not existing
            releaseMode = AMKUIApplicationReleaseModeUnknown;
        }
        else if (![mobileProvisionInfoDictionary count]) {
#       if TARGET_IPHONE_SIMULATOR
            releaseMode = AMKUIApplicationReleaseModeSim;
#       else
            releaseMode = AMKUIApplicationReleaseModeAppStore;
#       endif
        }
        else if ([[mobileProvisionInfoDictionary objectForKey:@"ProvisionsAllDevices"] boolValue]) {
            // enterprise distribution contains ProvisionsAllDevices - true
            releaseMode = AMKUIApplicationReleaseModeEnterprise;
        }
        else if ([mobileProvisionInfoDictionary objectForKey:@"ProvisionedDevices"] && [[mobileProvisionInfoDictionary objectForKey:@"ProvisionedDevices"] count] > 0) {
            // development contains UDIDs and get-task-allow is true
            // ad hoc contains UDIDs and get-task-allow is false
            NSDictionary *entitlements = [mobileProvisionInfoDictionary objectForKey:@"Entitlements"];
            if ([[entitlements objectForKey:@"get-task-allow"] boolValue]) {
                releaseMode = AMKUIApplicationReleaseModeDev;
            } else {
                releaseMode = AMKUIApplicationReleaseModeAdHoc;
            }
        }
        else {
            // app store contains no UDIDs (if the file exists at all?)
            releaseMode = AMKUIApplicationReleaseModeAppStore;
        }
    });
    return releaseMode;
}

- (NSString *)amk_localizedReleaseModeString {
    static NSString *localizedReleaseModeString = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localizedReleaseModeString = AMKStringFromApplicationReleaseMode(UIApplication.sharedApplication.amk_releaseMode);
    });
    return localizedReleaseModeString;
}

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end

//#if defined(DEBUG)
//
//@implementation UIApplication (AMKReleaseModeTests)
//
//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self test_amk_releaseMode];
//    });
//}
//
//+ (void)test_amk_releaseMode {
//    NSLog(@"LAUNCHED WITH RELEASE MODE: %@", UIApplication.sharedApplication.amk_localizedReleaseModeString);
//}
//
//@end
//
//#endif
