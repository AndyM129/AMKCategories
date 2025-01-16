//
//  AMKExampleViewControllerProtocol.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMKExampleViewModel.h"

/// 示例页 协议
@protocol AMKExampleViewControllerProtocol <NSObject>

/// ViewModel
@property (nonatomic, strong, readwrite, nullable) AMKExampleViewModel *viewModel;

/// 初始化方法
- (instancetype _Nullable)initWithViewModel:(AMKExampleViewModel *_Nullable)viewModel;

@end
