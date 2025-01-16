//
//  AMKExampleViewModel+AMKRootExampleViewModel.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleViewModel.h"

@interface AMKExampleViewModel (AMKRootExampleViewModel)

/// 根示例 ViewModel
@property (nonatomic, strong, readonly, nullable, class) AMKExampleViewModel *rootExampleViewModel;

@end
