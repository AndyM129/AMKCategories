//
//  AMKExampleViewModel.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 示例 ViewModel
@interface AMKExampleViewModel : NSObject

/// 标题
@property (nonatomic, copy, nullable) NSString *title;

/// 子标题 / 描述
@property (nonatomic, copy, nullable) NSString *subtitle;

/// 搜索关键词，分割搜索时 会与该字段中的内容做匹配检测
@property (nonatomic, strong, nullable) NSArray<NSString *> *keywords;

/// 示例页 类名，点击时 若该值非空，则跳转对应的页面
@property (nonatomic, copy, nullable) NSString *pageClassName;

/// 页面参数，当跳转该选项的示例页时，会传入该参数
@property (nonatomic, strong, nullable) NSDictionary *pageParams;

/// 当前选项 在实例库中的路径，有之前各选项的 title 拼接成
@property (nonatomic, copy, nullable) NSString *examplePath;

/// 子示例
@property (nonatomic, strong, readwrite, nullable) NSArray<AMKExampleViewModel *> *subExamples;

@end

#pragma mark -

@interface AMKExampleViewModel (AMKRootExampleViewModel)

/// 根示例 ViewModel
@property (nonatomic, strong, readonly, nullable, class) AMKExampleViewModel *rootExampleViewModel;

@end
