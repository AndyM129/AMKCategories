//
//  UIApplication+AMKMobileProvision.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/10.
//

#import "UIApplication+AMKMobileProvision.h"

NSString * AMKStringFromApplicationReleaseMode(AMKUIApplicationReleaseMode releaseMode) {
    NSString *localizedReleaseModeString = nil;
    switch (releaseMode) {
        case AMKUIApplicationReleaseModeSim: localizedReleaseModeString = @"Sim"; break;
        case AMKUIApplicationReleaseModeAdHoc: localizedReleaseModeString = @"AdHoc"; break;
        case AMKUIApplicationReleaseModeDev: localizedReleaseModeString = @"Dev"; break;
        case AMKUIApplicationReleaseModeAppStore: localizedReleaseModeString = @"AppStore"; break;
        case AMKUIApplicationReleaseModeEnterprise: localizedReleaseModeString = @"Enterprise"; break;
        default: localizedReleaseModeString = @"Unknow"; break;
    }
    return localizedReleaseModeString;
}

@implementation UIApplication (AMKMobileProvision)

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

- (NSTimeInterval)amk_timeIntervalToProvisionExpirationDate {
    NSDate *expirationDate = NSBundle.mainBundle.amk_mobileProvisionInfoDictionary[@"ExpirationDate"];
    if (!expirationDate) {
        NSLog(@"⚠️ ExpirationDate not found in '.mobileProvision' file.");
        return NSNotFound;
    }
    return [expirationDate timeIntervalSinceDate:NSDate.date];
}

- (CGFloat)amk_daysToProvisionExpirationDate {
    CGFloat timeIntervalToProvisionExpirationDate = [self amk_timeIntervalToProvisionExpirationDate];
    if (timeIntervalToProvisionExpirationDate == NSNotFound) return NSNotFound;
    return timeIntervalToProvisionExpirationDate / 60 / 60 / 24;
}

#pragma mark - Public Methods

- (UIAlertController *)amk_showAlertIfMobileProvisionWillExpire {
    return [self amk_showAlertIfMobileProvisionWillExpireInDays:30];
}

- (UIAlertController *)amk_showAlertIfMobileProvisionWillExpireInDays:(NSUInteger)willExpireInDays {
    // 若是AppStore包，则强制不显示该提示
    if (self.amk_releaseMode==AMKUIApplicationReleaseModeUnknown) return nil;
    if (self.amk_releaseMode==AMKUIApplicationReleaseModeAppStore) return nil;

    // 若未获取到失效日期，或未到达 willExpireInDays 则直接返回
    CGFloat expireInDays = [self amk_daysToProvisionExpirationDate];
    if (expireInDays==NSNotFound || expireInDays>willExpireInDays) return nil;
    
    // 若选了不再提醒，且剩余日期大于7天，则跳过该提示
    static NSInteger daysForForceAlert = 7;
    static NSString *doNotRemindAgainUntilAFewDaysAgoUserInfoKey = @"AMKMobileProvisionWillExpireAlertDoNotRemindAgainUntilAFewDaysAgo";
    BOOL doNotRemindAgainUntilAFewDaysAgo = [NSUserDefaults.standardUserDefaults boolForKey:doNotRemindAgainUntilAFewDaysAgoUserInfoKey];
    if (doNotRemindAgainUntilAFewDaysAgo && expireInDays>daysForForceAlert) return nil;
    
    // 根据当前语言构建弹窗文案
    NSString *title, *message, *cancelTitle, *doNotRemindAgainUntilAFewDaysAgoTitle;
    NSString *preferredLang = [[NSUserDefaults.standardUserDefaults objectForKey:@"AppleLanguages"] firstObject];
    if([preferredLang isEqualToString:@"zh-Hant"] || [preferredLang isEqualToString:@"zh-Hans"]){ // 当系统语言是中文或繁体中文时
        title = @"警告";
        message = [NSString stringWithFormat:@"您的打包证书将在%.0f天后过期，届时该应用将无法使用，请及时更新并重新构建应用。", floorf(expireInDays)];
        cancelTitle = @"知道了";
        doNotRemindAgainUntilAFewDaysAgoTitle = @"不再提醒";
    } else { //其它语言的情况下
        title = @"Warning";
        message = [NSString stringWithFormat:@"Your mobile provision will expire in %.0f days and the app will no longer be available.\nPlease update the provision in time and rebuild the app.", floorf(expireInDays)];
        cancelTitle = @"I got it";
        doNotRemindAgainUntilAFewDaysAgoTitle = @"Do Not Remind Again";
    }
    
    // 构建并显示警告弹窗
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDestructive handler:nil]];
    if (expireInDays>daysForForceAlert && !doNotRemindAgainUntilAFewDaysAgo) {
        [alertController addAction:[UIAlertAction actionWithTitle:doNotRemindAgainUntilAFewDaysAgoTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [NSUserDefaults.standardUserDefaults setBool:YES forKey:doNotRemindAgainUntilAFewDaysAgoUserInfoKey];
        }]];
    }
    [self amk_showAlertForMobileProvisionWillExpireInDays:alertController];
    return alertController;
}

/// 按需延时显示弹窗，以确保不会提示如下警告
/// Warning: Attempt to present <UIAlertController: 0x7fe72982ce00> on <UINavigationController: 0x7fe72a816000> whose view is not in the window hierarchy!
- (void)amk_showAlertForMobileProvisionWillExpireInDays:(UIAlertController *)alertController {
    UIViewController *rootViewController = self.delegate.window.rootViewController;
    if (!rootViewController || !rootViewController.view.window) {
        [self performSelector:@selector(amk_showAlertForMobileProvisionWillExpireInDays:) withObject:alertController afterDelay:.5];
        return;
    }
    [rootViewController presentViewController:alertController animated:YES completion:nil];
}

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
//@implementation UIApplication (AMKMobileProvisionTests)
//
//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self test_amk_releaseMode];
//        [self test_amk_showAlertIfMobileProvisionWillExpireInDays$];
//    });
//}
//
//+ (void)test_amk_releaseMode {
//    NSLog(@"LAUNCHED WITH RELEASE MODE: %@", UIApplication.sharedApplication.amk_localizedReleaseModeString);
//}
//
//+ (void)test_amk_showAlertIfMobileProvisionWillExpireInDays$ {
//    NSLog(@"TimeIntervalToProvisionExpirationDate = %f", UIApplication.sharedApplication.amk_timeIntervalToProvisionExpirationDate);
//    NSLog(@"DaysToProvisionExpirationDate = %f", UIApplication.sharedApplication.amk_daysToProvisionExpirationDate);
//    [UIApplication.sharedApplication amk_showAlertIfMobileProvisionWillExpireInDays:9999999];
//}
//
//@end
//
//#endif
