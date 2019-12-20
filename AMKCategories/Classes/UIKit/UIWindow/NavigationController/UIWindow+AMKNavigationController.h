//
//  UIWindow+AMKNavigationController.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/12/20.
//

#import <UIKit/UIKit.h>

/// 导航控制器 相关扩展
@interface UIWindow (AMKNavigationController)

/// UIApplication.sharedApplication.keyWindow  的 Top视图控制器
@property(nonatomic, readonly, class) UIViewController *amk_topViewController;

/// 当前 window 的 Top视图控制器
@property(nonatomic, readonly) UIViewController *amk_topViewController;

/// 回到当前 window 的根视图控制器
- (BOOL)amk_gotoRootViewControllerAnimated:(BOOL)animated;

/// 回到 UIApplication.sharedApplication.keyWindow 的根视图控制器
+ (BOOL)amk_gotoRootViewControllerAnimated:(BOOL)animated;

@end
