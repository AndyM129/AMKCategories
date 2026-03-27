//
//  BDERectSelectionView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BDERectSelectionViewHandleType) {
    BDERectSelectionViewHandleTypeCenter = 0, // 用于拖动整体
    BDERectSelectionViewHandleTypeTopLeft,
    BDERectSelectionViewHandleTypeTopRight,
    BDERectSelectionViewHandleTypeBottomRight,
    BDERectSelectionViewHandleTypeBottomLeft,
};

@interface BDERectSelectionView : UIView

/// 半透明黑遮罩层，可自行修改背景色
@property (nonatomic, strong, readonly, nullable) CAShapeLayer *overlayLayer;

/// 当前选中的区域
@property (nonatomic, assign, readwrite) CGRect selectionRect;

@end
