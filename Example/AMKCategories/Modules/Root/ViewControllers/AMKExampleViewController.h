//
//  AMKExampleViewController.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/10.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKStackViewController.h"
#import "AMKExampleStackView+AMKExampleStackViewConveniences.h"

/// 示例页
@interface AMKExampleViewController : UIViewController

/// 示例栈
@property (nonatomic, strong, readonly, nullable) AMKExampleStackView *exampleStackView;

/// 基于参数初始化
- (instancetype _Nullable)initWithParams:(NSDictionary *_Nullable)params;

@end
