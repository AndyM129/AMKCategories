//
//  AMKExampleViewController.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/10.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMKExampleViewControllerProtocol.h"
#import "AMKExampleStackView+AMKExampleStackViewConveniences.h"
#import "AMKExampleViewModel.h"

/// 示例页
@interface AMKExampleViewController : UIViewController <AMKExampleViewControllerProtocol>

/// 示例栈
@property (nonatomic, strong, readonly, nullable) AMKExampleStackView *exampleStackView;

@end
