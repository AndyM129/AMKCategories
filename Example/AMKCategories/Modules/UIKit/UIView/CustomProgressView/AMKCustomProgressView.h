//
//  AMKCustomProgressView.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/7/8.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 自定义进度条
@interface AMKCustomProgressView : UIView
@property (nonatomic, strong, readonly, nullable) UIView *contentView;
@property (nonatomic, strong, readonly, nullable) UIImageView *progressImageView;
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
@property (nonatomic, assign) CGFloat progress; //!< 0.0 .. 1.0, default is 0.0. values outside are pinned.

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
@end
