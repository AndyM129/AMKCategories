//
//  NSBundle+AMKAppVersionInfo.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/7/26.
//

#import "NSBundle+AMKAppVersionInfo.h"

NSString * const AMKBeforeBundleBuildVersionKey = @"AMKBeforeBundleBuildVersion";
NSString * const AMKBeforeBundleShortVersionKey = @"AMKBeforeBundleShortVersion";
NSString * const AMKBeforeLaunchingDateKey = @"AMKBeforeLaunchingDate";
NSString * const AMKLaunchingTimesKey = @"AMKLaunchingTimes";
static NSDate *kAMKBeforeLaunchingDate = nil;

@implementation NSBundle (AMKAppVersionInfo)

#pragma mark - Init Methods

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 记录启动时间
        kAMKBeforeLaunchingDate = [NSDate date];
        
        // 更新 NSUserDefaults
        NSInteger launchingTimes = [NSUserDefaults.standardUserDefaults integerForKey:AMKLaunchingTimesKey];
        [NSUserDefaults.standardUserDefaults setInteger:(launchingTimes+1) forKey:AMKLaunchingTimesKey];
        [NSUserDefaults.standardUserDefaults synchronize];
        
        // 添加 UIApplication 相关通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amk_applicationWillTerminateNotificationHandler:) name:UIApplicationWillTerminateNotification object:nil];
    });
}

#pragma mark - Properties

- (NSString *)amk_bundleIdentifier {
    static NSString *bundleIdentifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleIdentifier = self.infoDictionary[@"CFBundleIdentifier"];
    });
    return bundleIdentifier;
}

- (NSString *)amk_bundleName {
    static NSString *bundleName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleName = self.infoDictionary[@"CFBundleName"];
    });
    return bundleName;
}

- (NSString *)amk_bundleDisplayName {
    static NSString *bundleDisplayName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleDisplayName = self.infoDictionary[@"CFBundleDisplayName"];
    });
    return bundleDisplayName;
}

- (NSString *)amk_currentBundleBuildVersion {
    static NSString *currentBundleBuildVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentBundleBuildVersion = self.infoDictionary[@"CFBundleVersion"];
    });
    return currentBundleBuildVersion;
}

- (NSString *)amk_beforeBundleBuildVersion {
    static NSString *beforeBundleBuildVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beforeBundleBuildVersion = [NSUserDefaults.standardUserDefaults stringForKey:AMKBeforeBundleBuildVersionKey];
    });
    return beforeBundleBuildVersion;
}

- (NSString *)amk_currentBundleShortVersion {
    static NSString *currentBundleShortVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentBundleShortVersion = self.infoDictionary[@"CFBundleShortVersionString"];
    });
    return currentBundleShortVersion;
}

- (NSString *)amk_beforeBundleShortVersion {
    static NSString *beforeBundleShortVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beforeBundleShortVersion = [NSUserDefaults.standardUserDefaults stringForKey:AMKBeforeBundleShortVersionKey];
    });
    return beforeBundleShortVersion;
}

- (NSString *)amk_currentBundleLongVersion {
    static NSString *currentBundleLongVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentBundleLongVersion = [NSString stringWithFormat:@"%@.%@", self.amk_currentBundleShortVersion, self.amk_currentBundleBuildVersion];
    });
    return currentBundleLongVersion;
}

- (NSDate *)amk_beforeLaunchingDate {
    static NSDate *beforeLaunchingDate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beforeLaunchingDate = [NSUserDefaults.standardUserDefaults objectForKey:AMKBeforeLaunchingDateKey];
    });
    return beforeLaunchingDate;
}

- (NSInteger)amk_launchingTimes {
    static NSInteger launchingTimes = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        launchingTimes = MAX(0, [NSUserDefaults.standardUserDefaults integerForKey:AMKLaunchingTimesKey]);
    });
    return launchingTimes;
}

- (BOOL)amk_isFirstLaunching {
    static BOOL isFirstLaunching = YES;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstLaunching = self.amk_launchingTimes <= 1;
    });
    return isFirstLaunching;
}

- (BOOL)amk_isUpgradedLaunching {
    static BOOL isUpgradedLaunching = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.amk_beforeBundleShortVersion && [self.amk_beforeBundleShortVersion compare:self.amk_currentBundleShortVersion options:NSNumericSearch] == NSOrderedAscending) {
            isUpgradedLaunching = YES;
        }
    });
    return isUpgradedLaunching;
}

- (BOOL)amk_isDowngradedLaunching {
    static BOOL isDowngradedLaunching = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.amk_beforeBundleShortVersion && [self.amk_beforeBundleShortVersion compare:self.amk_currentBundleShortVersion options:NSNumericSearch] == NSOrderedDescending) {
            isDowngradedLaunching = YES;
        }
    });
    return isDowngradedLaunching;
}

#pragma mark - Public Methods

#pragma mark - Private Methods

+ (void)amk_applicationWillTerminateNotificationHandler:(NSNotification *)note {
    [NSUserDefaults.standardUserDefaults setObject:self.mainBundle.amk_currentBundleBuildVersion forKey:AMKBeforeBundleBuildVersionKey];
    [NSUserDefaults.standardUserDefaults setObject:self.mainBundle.amk_currentBundleShortVersion forKey:AMKBeforeBundleShortVersionKey];
    [NSUserDefaults.standardUserDefaults setObject:kAMKBeforeLaunchingDate forKey:AMKBeforeLaunchingDateKey];
    [NSUserDefaults.standardUserDefaults synchronize];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
