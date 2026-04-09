//
//  BDERectSelectionView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDERectSelectionView;

/// 矩形区域选择视图 - 控制点
typedef NS_ENUM(NSInteger, BDERectSelectionViewHandleType) {
    BDERectSelectionViewHandleTypeUnknown       = 0, //!< 矩形区域选择视图 - 控制点 - 未知，默认值
    BDERectSelectionViewHandleTypeLeftTop       = 1, //!< 矩形区域选择视图 - 控制点 - 四角 - 左上角 ┏
    BDERectSelectionViewHandleTypeRightTop      = 2, //!< 矩形区域选择视图 - 控制点 - 四角 - 右上角 ┓
    BDERectSelectionViewHandleTypeRightBottom   = 3, //!< 矩形区域选择视图 - 控制点 - 四角 - 右下角 ┛
    BDERectSelectionViewHandleTypeLeftBottom    = 4, //!< 矩形区域选择视图 - 控制点 - 四角 - 左下角 ┗
    BDERectSelectionViewHandleTypeTop           = 5, //!< 矩形区域选择视图 - 控制点 - 四边 - 上边 ┳
    BDERectSelectionViewHandleTypeRight         = 6, //!< 矩形区域选择视图 - 控制点 - 四边 - 右边 ┫
    BDERectSelectionViewHandleTypeBottom        = 7, //!< 矩形区域选择视图 - 控制点 - 四边 - 下边 ┻
    BDERectSelectionViewHandleTypeLeft          = 8, //!< 矩形区域选择视图 - 控制点 - 四边 - 左边 ┣
    BDERectSelectionViewHandleTypeBody          = 9, //!< 矩形区域选择视图 - 控制点 - 整体 □
    BDERectSelectionViewHandleTypeCount,             //!< 矩形区域选择视图 - 控制点 总个数
};

FOUNDATION_EXPORT NSString * _Nullable NSStringFromBDERectSelectionViewHandleType(BDERectSelectionViewHandleType handleType);

typedef void(^BDERectSelectionViewHandleImageViewLayoutBlcok)(BDERectSelectionView *_Nullable rectSelectionView, UIImageView *_Nullable selectionHandleImageView);

/// 矩形区域选择视图
@interface BDERectSelectionView : UIView

/// 半透明黑遮罩层，可自行修改背景色
@property (nonatomic, strong, readonly, nullable) CAShapeLayer *overlayLayer;

/// 选区视图，拖拽四角或中心时 会同步更新其 `frame`
@property (nonatomic, strong, readonly, nullable) UIView *selectionView;

/// 内容边距，仅在内容区域 可以调整选区，默认值为 `UIEdgeInsetsZero`
@property (nonatomic, assign, readwrite) UIEdgeInsets contentInsets;

/// 选区的最小尺寸，默认 `CGSizeZero`，即不设限
@property (nonatomic, assign, readwrite) CGSize minSelectionSize;

/// 四个角 控制点的大小，默认 `40*40` —— 请在设置对应的 `selectionHandleImageView` 之前赋值
@property (nonatomic, assign, readwrite) CGSize cornerHandleSize;

/// 四个边 控制点的大小（即 宽或高），默认 `40` —— 请在设置对应的 `selectionHandleImageView` 之前赋值
@property (nonatomic, assign, readwrite) CGFloat sideHandleSize;

/// 平移手势，以便处理 `selectionView` 四角拖拽、中心移动
@property (nonatomic, strong, readonly, nullable) UIPanGestureRecognizer *panGestureRecognizer;

/// 获取指定 `handleType` 对应的 `selectionHandleImageView`
- (UIImageView *_Nullable)selectionHandleImageViewWithType:(BDERectSelectionViewHandleType)handleType;

/// 获取指定 `handleType` 对应的 `selectionHandleImageView`，并支持直接在 `layoutBlcok` 中进行布局&样式的更新
- (UIImageView *_Nullable)selectionHandleImageViewWithType:(BDERectSelectionViewHandleType)handleType layoutBlcok:(BDERectSelectionViewHandleImageViewLayoutBlcok _Nullable)layoutBlcok;

@end

#pragma mark -

// ⬇︎ 可手动 解开/添加 注释，以 启用/禁用 Debug Log
#ifndef __OPTIMIZE__
#define BDERectSelectionViewLog(FORMAT, ...) fprintf(stderr, "%s 【%s】🧵 %s ➤ %s 📍%s #%d\n", NSDate.new.description.UTF8String, "BDERectSelectionView", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String], __FUNCTION__, __LINE__)
#endif
#ifndef BDERectSelectionViewLog
#define BDERectSelectionViewLog(...) {}
#endif
