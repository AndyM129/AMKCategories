//
//  NSDictionary+AMKProtocolPropertiesExample.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/9/5.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "NSDictionary+AMKProtocolPropertiesExample.h"

#pragma mark - 示例1

@implementation NSDictionary (AMKExampleDictionaryPropertiesProtocol_1)

/// 【示意1】支持自定义实现对应属性的 getter
- (id)amkpp_aCustomObjectWithCustomImplementation {
    return [NSString stringWithFormat:@"自定义实现：%@", [self objectForKey:@"aCustomObjectWithCustomImplementation"]];
}

@end
