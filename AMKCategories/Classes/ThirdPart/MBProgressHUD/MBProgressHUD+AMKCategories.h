//
//  MBProgressHUD+AMKCategories.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2022/6/22.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+AMKCustomView.h"

@interface MBProgressHUD (AMKCategories)

/// 默认背景色
@property (strong, nonatomic, nullable) UIColor *amk_contentBackgroundColor UI_APPEARANCE_SELECTOR;

/// 默认标题字体
@property (strong, nonatomic, nullable) UIFont *amk_labelFont UI_APPEARANCE_SELECTOR;

/// 默认内容字体
@property (strong, nonatomic, nullable) UIFont *amk_detailsLabelFont UI_APPEARANCE_SELECTOR;

/// 默认标题行间距
@property (nonatomic, assign, readwrite) CGFloat amk_labelLineSpacing UI_APPEARANCE_SELECTOR;

/// 默认内容行间距
@property (nonatomic, assign, readwrite) CGFloat amk_detailsLabelLineSpacing UI_APPEARANCE_SELECTOR;

/// 默认的显示容器视图
+ (UIView *_Nullable)amk_defaultSuperview;

/// 文本吐司 - 仅内容+父视图+所属页面+移除之前的HUD+不阻隔交互
+ (instancetype _Nullable)amk_showTextHUDWithMessage:(id _Nullable)message inView:(UIView *_Nullable)view responder:(UIResponder *_Nullable)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated;

/// 文本吐司 - 标题+内容+父视图+所属页面+移除之前的HUD+不阻隔交互
+ (instancetype _Nullable)amk_showTextHUDWithTitle:(id _Nullable)title message:(id _Nullable)message inView:(UIView *_Nullable)view responder:(UIResponder *_Nullable)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated;

/// 文本吐司 - 标题+内容+父视图+所属页面+移除之前的HUD+不阻隔交互
+ (instancetype _Nullable)amk_showTextHUDWithTitle:(id _Nullable)title message:(id _Nullable)message inView:(UIView *_Nullable)view responder:(UIResponder *_Nullable)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled;

/// Loading吐司 - Loading+标题+内容+父视图+所属页面+移除之前的HUD+不阻隔交互
+ (instancetype _Nullable)amk_showLoadingHUDWithTitle:(id _Nullable)title message:(id _Nullable)message inView:(UIView *_Nullable)view responder:(UIResponder *_Nullable)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled;

/// 自定义吐司 - 视图+标题+内容+父视图+所属页面+移除之前的HUD+不阻隔交互
/// 注：customView 须实现 `-intrinsicContentSize` 方法，并设置 `self.translatesAutoresizingMaskIntoConstraints = NO;`，可使用 AMKMBProgressHUDCustomView
+ (instancetype _Nullable)amk_showHUDWithCustomView:(UIView *_Nullable)customView title:(id _Nullable)title message:(id _Nullable)message inView:(UIView *_Nullable)view responder:(UIResponder *_Nullable)responder duration:(NSTimeInterval)showDuration animated:(BOOL)animated;

/// 自定义吐司 - 视图+标题+内容+父视图+所属页面+移除之前的HUD(默认YES)+不阻隔交互
/// 注：customView 须实现 `-intrinsicContentSize` 方法，并设置 `self.translatesAutoresizingMaskIntoConstraints = NO;`，可使用 AMKMBProgressHUDCustomView
+ (instancetype _Nullable)amk_showHUDWithCustomView:(UIView *_Nullable)customView title:(id _Nullable)title message:(id _Nullable)message inView:(UIView *_Nullable)view responder:(UIResponder *_Nullable)responder duration:(NSTimeInterval)showDuration hideBeforeHUD:(BOOL)hideBeforeHUD animated:(BOOL)animated;

/// 自定义吐司 - 视图+标题+内容+父视图+所属页面+移除之前的HUD(默认YES)+是否阻隔交互(默认NO)
/// 注：customView 须实现 `-intrinsicContentSize` 方法，并设置 `self.translatesAutoresizingMaskIntoConstraints = NO;`，可使用 AMKMBProgressHUDCustomView
+ (instancetype _Nullable)amk_showHUDWithCustomView:(UIView *_Nullable)customView title:(id _Nullable)title message:(id _Nullable)message inView:(UIView *_Nullable)view responder:(UIResponder *_Nullable)responder duration:(NSTimeInterval)showDuration hideBeforeHUD:(BOOL)hideBeforeHUD animated:(BOOL)animated userInteractionEnabled:(BOOL)userInteractionEnabled;

@end
