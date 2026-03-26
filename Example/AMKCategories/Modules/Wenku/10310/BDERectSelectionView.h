//
//  BDERectSelectionView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2026/3/26.
//  Copyright © 2026 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDERectSelectionView : UIView

/// 当前选中的区域
@property (nonatomic, assign, readwrite) CGRect selectionRect;

@property (nonatomic, strong, readonly, nullable) CAShapeLayer *overlayLayer;

@end
