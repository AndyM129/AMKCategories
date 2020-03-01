//
//  CAAnimation+AMKAnimationDelegate.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/3/1.
//

#import <QuartzCore/QuartzCore.h>

/// CAAnimation 代理回调
@interface CAAnimation (AMKCAAnimationDelegate) <CAAnimationDelegate>
@property(nonatomic, readonly, getter=amk_isAnimating) BOOL amk_animating;
@property(nonatomic, copy, nullable) void(^amk_animationDidStartBlock)(CAAnimation *_Nullable animation);
@property(nonatomic, copy, nullable) void(^amk_animationDidStopBlock)(CAAnimation *_Nullable animation, BOOL finished);
@end
