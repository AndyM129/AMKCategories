//
//  WKNVoiceRecognitionPopupView.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDEPopupView.h"

/// 语音识别浮层面板
@interface WKNVoiceRecognitionPopupView : BDEPopupView

@end

#pragma mark -

@interface WKNVoiceRecognitionPopupView (WKNAppearance)
@property (nonatomic, assign, readonly, class) UIEdgeInsets contentViewPadding; //!< contentView 的内边距
//@property (nonatomic, assign, readonly, class) CGFloat contentViewMinHeight; //!< contentView 最小高度
@property (nonatomic, assign, readonly) CGFloat preferredHeight; //!< 当前视图 基于当前状态的 显示高度
@end
