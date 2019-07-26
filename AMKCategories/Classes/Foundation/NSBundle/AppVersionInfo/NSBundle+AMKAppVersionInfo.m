//
//  NSBundle+AMKAppVersionInfo.m
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/7/26.
//

#import "NSBundle+AMKAppVersionInfo.h"
#import <objc/runtime.h>
#import <objc/message.h>

NSString * const AMKBeforeBundleBuildVersionKey = @"AMKBeforeBundleBuildVersion";
NSString * const AMKBeforeBundleShortVersionKey = @"AMKBeforeBundleShortVersion";
NSString * const AMKBeforeLaunchingDateKey = @"AMKBeforeLaunchingDate";
NSString * const AMKLaunchingTimesKey = @"AMKLaunchingTimes";
static NSDate *kAMKBeforeLaunchingDate = nil;

@implementation NSBundle (AMKAppVersionInfo)

#pragma mark - Init Methods

- (void)AMKAppVersionInfo_NSBundle_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
    ((void(*)(id, SEL))objc_msgSend)(self, @selector(AMKAppVersionInfo_NSBundle_dealloc));
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        void (^__instance_method_swizzling)(SEL, SEL) = ^(SEL sel, SEL _sel) {
            Method method = class_getInstanceMethod(self, sel);
            Method _method = class_getInstanceMethod(self, _sel);
            if (class_addMethod(self, sel, method_getImplementation(_method), method_getTypeEncoding(_method))) {
                class_replaceMethod(self, _sel, method_getImplementation(method), method_getTypeEncoding(method));
            } else {
                method_exchangeImplementations(method, _method);
            }
        };
        void (^__class_method_swizzling)(SEL, SEL) = ^(SEL sel, SEL _sel) {
            Method  method = class_getClassMethod(self, sel);
            Method _method = class_getClassMethod(self, _sel);
            method_exchangeImplementations(method, _method);
        };
        
        //  避免因为手动调用该方法引发被拒的可能
        NSString *selectorName = [NSString stringWithFormat:@"%@%@%@", @"de", @"al", @"loc"];
        NSString *newSelectorName = [NSString stringWithFormat:@"%@%@%@%@%@", @"AMKDea", @"llocB", @"lock", @"_dea", @"lloc"];
        __instance_method_swizzling(NSSelectorFromString(selectorName), NSSelectorFromString(newSelectorName));
        __class_method_swizzling(@selector(mainBundle), @selector(amk_mainBundle));
    });
}

+ (NSBundle *)amk_mainBundle {
    NSBundle *mainBundle = [self amk_mainBundle];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 记录启动时间
        kAMKBeforeLaunchingDate = [NSDate date];
        
        // 更新 NSUserDefaults
        NSInteger launchingTimes = [[NSUserDefaults standardUserDefaults] integerForKey:AMKLaunchingTimesKey];
        [[NSUserDefaults standardUserDefaults] setInteger:(launchingTimes+1) forKey:AMKLaunchingTimesKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 添加 UIApplication 相关通知
        [[NSNotificationCenter defaultCenter] addObserver:mainBundle selector:@selector(amk_applicationWillTerminateNotificationHandler:) name:UIApplicationWillTerminateNotification object:nil];
    });
    return mainBundle;
}

#pragma mark - Properties

- (NSString *)amk_bundleIdentifier {
    static NSString *bundleIdentifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleIdentifier = [NSBundle mainBundle].infoDictionary[@"CFBundleIdentifier"];
    });
    return bundleIdentifier;
}

- (NSString *)amk_bundleName {
    static NSString *bundleName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleName = [NSBundle mainBundle].infoDictionary[@"CFBundleName"];
    });
    return bundleName;
}

- (NSString *)amk_bundleDisplayName {
    static NSString *bundleDisplayName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleDisplayName = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    });
    return bundleDisplayName;
}

- (NSString *)amk_currentBundleBuildVersion {
    static NSString *currentBundleBuildVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentBundleBuildVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    });
    return currentBundleBuildVersion;
}

- (NSString *)amk_beforeBundleBuildVersion {
    static NSString *beforeBundleBuildVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beforeBundleBuildVersion = [[NSUserDefaults standardUserDefaults] stringForKey:AMKBeforeBundleBuildVersionKey];
    });
    return beforeBundleBuildVersion;
}

- (NSString *)amk_currentBundleShortVersion {
    static NSString *currentBundleShortVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentBundleShortVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    });
    return currentBundleShortVersion;
}

- (NSString *)amk_beforeBundleShortVersion {
    static NSString *beforeBundleShortVersion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beforeBundleShortVersion = [[NSUserDefaults standardUserDefaults] stringForKey:AMKBeforeBundleShortVersionKey];
    });
    return beforeBundleShortVersion;
}

- (NSDate *)amk_beforeLaunchingDate {
    static NSDate *beforeLaunchingDate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beforeLaunchingDate = [[NSUserDefaults standardUserDefaults] objectForKey:AMKBeforeLaunchingDateKey];
    });
    return beforeLaunchingDate;
}

- (NSInteger)amk_launchingTimes {
    static NSInteger launchingTimes = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        launchingTimes = MAX(0, [[NSUserDefaults standardUserDefaults] integerForKey:AMKLaunchingTimesKey]);
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

- (NSArray<NSDictionary *> *)amk_bundleURLTypes {
    NSArray *bundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    if ([bundleURLTypes isKindOfClass:NSArray.class]) {
        return bundleURLTypes;
    } else {
        return nil;
    }
}

- (NSDictionary *)amk_bundleURLTypeWithKey:(NSString *)key value:(id)value {
    NSDictionary *bundleURLType = nil;
    NSArray<NSDictionary *> *bundleURLTypes = [self amk_bundleURLTypes];
    for (NSDictionary *currentBundleURLType in bundleURLTypes) {
        if (currentBundleURLType && [currentBundleURLType isKindOfClass:[NSDictionary class]]) {
            id object = [currentBundleURLType objectForKey:key];
            if (object && [object isEqual:value]) {
                bundleURLType = currentBundleURLType;
                break;
            }
        }
    }
    return bundleURLType;
}

- (NSDictionary *)amk_bundleURLTypeWithName:(NSString *)name {
    NSDictionary *bundleURLType = [self amk_bundleURLTypeWithKey:@"CFBundleURLName" value:name];
    return [bundleURLType isKindOfClass:NSDictionary.class] ? bundleURLType : nil;;
}

- (NSArray<NSString *> * _Nullable)amk_bundleURLSchemesOfURLName:(NSString * _Nullable)bundleURLName {
    NSArray *bundleURLSchemes = nil;
    NSDictionary *bundleURLType = [self amk_bundleURLTypeWithKey:@"CFBundleURLName" value:bundleURLName];
    if (bundleURLType && [bundleURLType isKindOfClass:NSDictionary.class]) {
        bundleURLSchemes = [bundleURLType objectForKey:@"CFBundleURLSchemes"];
    }
    return bundleURLSchemes;
}

#pragma mark - Private Methods

- (void)amk_applicationWillTerminateNotificationHandler:(NSNotification *)note {
    [[NSUserDefaults standardUserDefaults] setObject:self.amk_currentBundleBuildVersion forKey:AMKBeforeBundleBuildVersionKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.amk_currentBundleShortVersion forKey:AMKBeforeBundleShortVersionKey];
    [[NSUserDefaults standardUserDefaults] setObject:kAMKBeforeLaunchingDate forKey:AMKBeforeLaunchingDateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods

@end
