//
//  AMKExampleViewModel+AMKAssociatedObject.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleViewModel.h"

/// 本地扩展的 关联对象
@interface AMKExampleViewModel (AMKAssociatedObject)

/// 当前选项 在实例库中的路径，有之前各选项的 title 拼接成
@property (nonatomic, copy, nullable) NSString *examplePath;

/// 是否已展开，默认 `NO`
@property (nonatomic, assign, readwrite) BOOL isExpanded;

@end
