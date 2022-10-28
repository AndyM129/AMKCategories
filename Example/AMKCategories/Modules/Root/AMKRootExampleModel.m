//
//  AMKRootExampleModel.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/10/28.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKRootExampleModel.h"

@implementation AMKRootExampleModel

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype _Nonnull)initWithClazzName:(NSString *_Nullable)clazzName title:(NSString *_Nullable)title {
    return [self initWithClazzName:clazzName title:title detail:nil];
}

- (instancetype _Nonnull)initWithClazzName:(NSString *_Nullable)clazzName title:(NSString *_Nullable)title detail:(NSString *_Nullable)detail {
    return [self initWithBlock:^(AMKRootExampleModel * _Nonnull model) {
        model.clazzName = clazzName;
        model.title = title;
        model.detail = detail;
    }];
}

- (instancetype _Nonnull)initWithBlock:(AMKRootExampleModelInitBlock _Nullable)block {
    if (self = [super init]) {
        !block ? nil : block(self);
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Getters & Setters

#pragma mark - Data & Networking

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
