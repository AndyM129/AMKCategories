//
//  AMKRefreshHeader.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/11/7.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>
#import "AMKRefreshHeaderToastView.h"
@class AMKRefreshHeader;

typedef NSTimeInterval(^AMKRefreshHeaderWillEndRefreshingBlock)(AMKRefreshHeader *_Nullable refreshHeader);

/// 刷新的具体场景
typedef NS_ENUM(NSInteger, AMKRefreshScene) {
    AMKRefreshSceneDefault = 0,                     //!< 默认
    AMKRefreshSceneReloadBarButtonItemClicked,      //!< 点击刷新按钮
    AMKRefreshSceneTableViewCellClicked,            //!< 点击列表行
};

@interface AMKRefreshHeader : MJRefreshNormalHeader
@property (nonatomic, strong, readonly, nullable) AMKRefreshHeaderToastView *toastView;
@property (nonatomic, copy, readwrite, nullable) AMKRefreshHeaderWillEndRefreshingBlock willEndRefreshingBlock;
@property (nonatomic, assign, readonly) AMKRefreshScene scene; //!< 当前的刷新场景 —— ⚠️ 在结束刷新时，会自动重置为默认值

- (void)beginRefreshingWithScene:(AMKRefreshScene)scene completionBlock:(MJRefreshComponentAction _Nullable)completionBlock;

@end
