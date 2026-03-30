//
//  BDERectSelectionView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDERectSelectionView;

typedef NS_ENUM(NSInteger, BDERectSelectionViewHandleType) {
    BDERectSelectionViewHandleTypeCenter = 0, // 用于拖动整体
    BDERectSelectionViewHandleTypeTopLeft,
    BDERectSelectionViewHandleTypeTopRight,
    BDERectSelectionViewHandleTypeBottomRight,
    BDERectSelectionViewHandleTypeBottomLeft,
    BDERectSelectionViewHandleTypeCount,
};

typedef void(^BDERectSelectionViewHandleImageViewLayoutBlcok)(BDERectSelectionView *_Nullable rectSelectionView, UIImageView *_Nullable selectionHandleImageView);

@interface BDERectSelectionView : UIView

/// 半透明黑遮罩层，可自行修改背景色
@property (nonatomic, strong, readonly, nullable) CAShapeLayer *overlayLayer;

/// 选区视图，拖拽四角或中心时 会同步更新其 `frame`
@property (nonatomic, strong, readonly, nullable) UIView *selectionView;

/// 内容边距，仅在内容区域 可以调整选区，默认值为 `UIEdgeInsetsZero`
@property (nonatomic, assign, readwrite) UIEdgeInsets contentInsets;

/// 选区的最小尺寸，默认 `CGSizeZero`，即不设限
@property (nonatomic, assign, readwrite) CGSize minSelectionSize;

/// 平移手势，以便处理 `selectionView` 四角拖拽、中心移动
@property (nonatomic, strong, readonly, nullable) UIPanGestureRecognizer *panGestureRecognizer;

- (UIImageView *_Nullable)selectionHandleImageViewWithType:(BDERectSelectionViewHandleType)handleType;

- (UIImageView *_Nullable)selectionHandleImageViewWithType:(BDERectSelectionViewHandleType)handleType layoutBlcok:(BDERectSelectionViewHandleImageViewLayoutBlcok _Nullable)layoutBlcok;

@end
