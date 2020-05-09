//
//  UIWindow+AMKReleaseMode.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/9.
//

#import <UIKit/UIKit.h>
#import <AMKCategories/UIView+AMKViewLevel.h>
#import <AMKCategories/UIApplication+AMKReleaseMode.h>

/// 包释放模式 角标 视图层级
UIKIT_EXTERN const AMKViewLevel AMKViewLevelReleaseModeCornerMarkLabel;

/// 包释放模式
@interface UIWindow (AMKReleaseMode)

/// 包释放模式 角标
@property(nonatomic, strong, nullable, readonly) UILabel *amk_releaseModeCornerMarkLabel;

@end
