//
//  NSBundle+AMKAppVersionInfo.h
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/7/26.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * _Nonnull const AMKBeforeBundleBuildVersionKey;
FOUNDATION_EXPORT NSString * _Nonnull const AMKBeforeBundleShortVersionKey;
FOUNDATION_EXPORT NSString * _Nonnull const AMKBeforeLaunchingDateKey;
FOUNDATION_EXPORT NSString * _Nonnull const AMKLaunchingTimesKey;

/// App信息的扩展。
/// 注：对于上一次启动的App信息，因是在接收到 UIApplicationWillTerminateNotification 通知时处理，故对模拟器或Xcode端终止程序时无法生效
@interface NSBundle (AMKAppVersionInfo)
@property(nonatomic, strong, readonly, nonnull) NSString *amk_bundleIdentifier;                 //!< Bundle ID
@property(nonatomic, strong, readonly, nonnull) NSString *amk_bundleName;                       //!< Bundle Name
@property(nonatomic, strong, readonly, nonnull) NSString *amk_bundleDisplayName;                //!< Display Name
@property(nonatomic, strong, readonly, nonnull) NSString *amk_currentBundleBuildVersion;        //!< 当前构建版本号
@property(nonatomic, strong, readonly, nullable) NSString *amk_beforeBundleBuildVersion;        //!< 上一次启动时的构建版本号
@property(nonatomic, strong, readonly, nonnull) NSString *amk_currentBundleShortVersion;        //!< 当前版本号
@property(nonatomic, strong, readonly, nullable) NSString *amk_beforeBundleShortVersion;        //!< 上一次启动时的版本号
@property(nonatomic, strong, readonly, nullable) NSDate *amk_beforeLaunchingDate;               //!< 上一次启动时间
@property(nonatomic, assign, readonly) NSInteger amk_launchingTimes;                            //!< 截止本次启动的启动次数
@property(nonatomic, assign, readonly) BOOL amk_isFirstLaunching;                               //!< 是否是安装后第一次启动
@property(nonatomic, assign, readonly) BOOL amk_isUpgradedLaunching;                            //!< 是否是升级后第一次启动
@property(nonatomic, assign, readonly) BOOL amk_isDowngradedLaunching;                          //!< 是否是降级后第一次启动
@end


