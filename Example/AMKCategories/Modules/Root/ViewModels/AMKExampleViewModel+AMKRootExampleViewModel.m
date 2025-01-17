//
//  AMKExampleViewModel+AMKRootExampleViewModel.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/1/16.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMKExampleViewModel+AMKRootExampleViewModel.h"
#import <YYModel/YYModel.h>

@implementation AMKExampleViewModel (AMKRootExampleViewModel)

#pragma mark - Init Methods

#pragma mark - Getters & Setters

+ (AMKExampleViewModel *)rootExampleViewModel {
    static AMKExampleViewModel *_rootExampleViewModel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *plistPath = [NSBundle.mainBundle pathForResource:@"AMKExamples" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary.alloc initWithContentsOfFile:plistPath];
        _rootExampleViewModel = [AMKExampleViewModel yy_modelWithDictionary:dict];
        NSLog(@"AMKExampleViewModel.rootExampleViewModel = %@", [_rootExampleViewModel treeDescription]);
    });
    return _rootExampleViewModel;
}

#pragma mark - Data & Networking

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
