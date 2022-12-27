//
//  WKNVipBenefitsAnimationView.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/12/26.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKNVipBenefitsAnimationView;

typedef void (^WKNVipBenefitsAnimationViewCompletionBlock)(WKNVipBenefitsAnimationView *_Nullable animationView, BOOL animationFinished);

/// 会员福利 首页动画
@interface WKNVipBenefitsAnimationView : UIView

@property (nonatomic, weak, readwrite, nullable) UIView *destinationView;

@property (nonatomic, copy, readwrite, nullable) WKNVipBenefitsAnimationViewCompletionBlock completionBlock;

- (void)playInView:(UIView *_Nullable)superview;

@end
