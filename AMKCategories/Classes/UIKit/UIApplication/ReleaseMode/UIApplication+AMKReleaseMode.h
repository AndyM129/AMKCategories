//
//  UIApplication+AMKReleaseMode.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/9.
//

#import <UIKit/UIKit.h>

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
NSString * AMKStringFromApplicationReleaseMode(AMKUIApplicationReleaseMode releaseMode);

/// 包释放模式
@interface UIApplication (AMKReleaseMode)

/// 包释放模式
@property(nonatomic,readonly) AMKUIApplicationReleaseMode amk_releaseMode;

/// 包释放模式 描述
@property(nonatomic,readonly) NSString *amk_localizedReleaseModeString;

@end
