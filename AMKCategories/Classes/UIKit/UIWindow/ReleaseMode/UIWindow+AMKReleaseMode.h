//
//  UIWindow+AMKReleaseMode.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/9.
//

#import <UIKit/UIKit.h>
#import <AMKCategories/UIView+AMKViewLevel.h>
#import <AMKCategories/UIApplication+AMKMobileProvision.h>

/// 包释放模式 角标 视图层级
UIKIT_EXTERN const AMKViewLevel AMKViewLevelReleaseModeCornerMarkLabel;

/// 包释放模式
@interface UIWindow (AMKReleaseMode)

/// 是否启用并显示 包释放模式 角标（注：在 AppStore 模式下则强制为NO）
@property(nonatomic, assign) BOOL amk_releaseModeCornerMarkEnable;

@end

/// 包释放模式
@interface UIApplication (AMKReleaseMode)

/// 是否启用并显示 包释放模式 角标（注：在 AppStore 模式下则强制为NO）
@property(nonatomic, assign) BOOL amk_releaseModeCornerMarkEnable;

@end
