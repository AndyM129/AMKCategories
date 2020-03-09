//
//  UIView+AMKViewLevel.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/3/9.
//

#import <UIKit/UIKit.h>

/// 视图优先级（The position of the view in the z-axis.）
typedef CGFloat AMKViewLevel;
UIKIT_EXTERN const AMKViewLevel AMKViewLevelDefault;            //!< 视图优先级：默认（0）
UIKIT_EXTERN const AMKViewLevel AMKViewLevelLow;                //!< 视图优先级：低级
UIKIT_EXTERN const AMKViewLevel AMKViewLevelLowHigher;          //!< 视图优先级：低级偏高
UIKIT_EXTERN const AMKViewLevel AMKViewLevelMiddle;             //!< 视图优先级：中级
UIKIT_EXTERN const AMKViewLevel AMKViewLevelMiddleHigher;       //!< 视图优先级：中级偏上
UIKIT_EXTERN const AMKViewLevel AMKViewLevelHigh;               //!< 视图优先级：高级


@interface UIView (AMKViewLevel)
@property (nonatomic, assign) AMKViewLevel amk_viewLevel;       //!< 视图优先级
@end
