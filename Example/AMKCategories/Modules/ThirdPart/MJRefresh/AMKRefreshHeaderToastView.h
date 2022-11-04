//
//  AMKRefreshHeaderToastView.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/11/4.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMKRefreshHeaderToastView;
typedef void(^AMKRefreshHeaderToastViewCompletionBlock)(AMKRefreshHeaderToastView *_Nonnull toastView);

/// 下拉刷新 - 结束刷新前显示的「为您推荐xx条新内容」提示
@interface AMKRefreshHeaderToastView : UIView
@property (nonatomic, strong, readonly, nullable) UIView *contentView;
@property (nonatomic, strong, readonly, nullable) UIImageView *imageView;
@property (nonatomic, strong, readonly, nullable) UILabel *titleLabel;

- (void)show:(BOOL)willShow animated:(BOOL)animated completion:(AMKRefreshHeaderToastViewCompletionBlock _Nullable)completion;
@end
