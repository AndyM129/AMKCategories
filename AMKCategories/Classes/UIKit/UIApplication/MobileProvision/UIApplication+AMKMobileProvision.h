//
//  UIApplication+AMKMobileProvision.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/10.
//

#import <UIKit/UIKit.h>
#import <AMKCategories/NSBundle+AMKMobileProvision.h>

/// 包释放模式
typedef NS_ENUM(NSInteger, AMKUIApplicationReleaseMode) {
    AMKUIApplicationReleaseModeUnknown,
    AMKUIApplicationReleaseModeSim,
    AMKUIApplicationReleaseModeDev,
    AMKUIApplicationReleaseModeAdHoc,
    AMKUIApplicationReleaseModeAppStore,
    AMKUIApplicationReleaseModeEnterprise,
};

/// 包释放模式 描述
NSString * _Nullable AMKStringFromApplicationReleaseMode(AMKUIApplicationReleaseMode releaseMode);

/// MobileProvision 信息获取
@interface UIApplication (AMKMobileProvision)

/// 包释放模式
@property(nonatomic, readonly) AMKUIApplicationReleaseMode amk_releaseMode;

/// 包释放模式 描述
@property(nonatomic, readonly, nullable) NSString *amk_localizedReleaseModeString;

/// 距离 MobileProvision 失效的剩余秒数（若处理异常，则返回 NSNotFound）
@property(nonatomic, assign, readonly) NSTimeInterval amk_timeIntervalToProvisionExpirationDate;

/// 距离 MobileProvision 失效的剩余天数（若处理异常，则返回 NSNotFound）
@property(nonatomic, assign, readonly) CGFloat amk_daysToProvisionExpirationDate;

/// 若 MobileProvision 即将过期则弹窗提示（默认是30天）
- (UIAlertController *_Nullable)amk_showAlertIfMobileProvisionWillExpire;

/// 若 MobileProvision 即将在 willExpireInDays 天后过期则弹窗提示
- (UIAlertController *_Nullable)amk_showAlertIfMobileProvisionWillExpireInDays:(NSUInteger)willExpireInDays;

@end
