//
//  WKNVoiceRecognitionButton.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2024/1/24.
//  Copyright © 2024 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 语音识别按钮 当前交互状态
typedef NS_ENUM(NSUInteger, WKNVoiceRecognitionButtonState) {
    WKNVoiceRecognitionButtonStateNormal = 0,       //!< 默认的「按住说话 按钮」状态
    WKNVoiceRecognitionButtonStateTouchDown,        //!< 按下
    WKNVoiceRecognitionButtonStateTouchDragEnter,   //!< 手势移出按钮范围
    WKNVoiceRecognitionButtonStateTouchDragExit,    //!< 手势移入按钮范围
    WKNVoiceRecognitionButtonStateTouchCancel,      //!< 取消
    WKNVoiceRecognitionButtonStateTouchUp,          //!< 松手
};

/// 语音识别按钮
@interface WKNVoiceRecognitionButton : UIView

/// 标题
@property (nonatomic, strong, readonly, nullable) UILabel *titleLabel;

/// 当前的交互状态
@property (nonatomic, assign, readonly) WKNVoiceRecognitionButtonState state;

@end
