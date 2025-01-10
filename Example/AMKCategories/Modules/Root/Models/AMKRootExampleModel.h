//
//  AMKRootExampleModel.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/10/28.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AMKRootExampleModel;

/// 示例 Model - 初始化 block
typedef void(^AMKRootExampleModelInitBlock)(AMKRootExampleModel *_Nonnull model);

/// 示例 Model
@interface AMKRootExampleModel : NSObject
@property (nonatomic, copy, readwrite, nullable) NSString *clazzName; //!< 示例的类名
@property (nonatomic, copy, readwrite, nullable) NSString *title; //!< 示例标题
@property (nonatomic, copy, readwrite, nullable) NSString *detail; //!< 示例描述

- (instancetype _Nonnull)initWithClazzName:(NSString *_Nullable)clazzName title:(NSString *_Nullable)title;
- (instancetype _Nonnull)initWithClazzName:(NSString *_Nullable)clazzName title:(NSString *_Nullable)title detail:(NSString *_Nullable)detail;
- (instancetype _Nonnull)initWithBlock:(AMKRootExampleModelInitBlock _Nullable)block;
@end
