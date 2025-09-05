//
//  NSDictionary+AMKProtocolPropertiesExample.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/9/5.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <AMKCategories/NSDictionary+AMKProtocolProperties.h>

#pragma mark - 示例1

/// 【示例1】在协议中声明 xxx 字典中 key 对应的属性，以便支持直接通过属性访问对应Key值
@protocol AMKExampleDictionaryPropertiesProtocol_1 <NSObject>
@optional
@property (nonatomic, copy, readonly, nullable) id amkpp_aStringObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aIntegerObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aBoolObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aDoubleObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aNumberObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_anArrayObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aDictObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aNullObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aBlockObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aCustomObject;
@property (nonatomic, copy, readonly, nullable) id amkpp_aCustomObjectWithCustomImplementation;
@end

/// 【示例1】给 NSDictionary 指定该属性协议
@interface NSDictionary (AMKExampleDictionaryPropertiesProtocol_1) <AMKExampleDictionaryPropertiesProtocol_1>

@end

//#pragma mark - 示例2
//
///// 【示例2】在协议中声明 xxx 字典中 key 对应的属性，以便支持直接通过属性访问对应Key值
//@protocol AMKExampleDictionaryPropertiesProtocol_2 <NSObject>
//@optional
//// 正确使用：声明类型 与 类型后缀 一致
//@property (nonatomic, readonly, copy, nullable) NSString *amkpp_aStringObject__stringValue;
//@property (nonatomic, readonly, assign) NSInteger amkpp_aIntegerObject__integerValue;
//@property (nonatomic, readonly, assign) BOOL amkpp_aBoolObject__boolValue;
//@property (nonatomic, readonly, assign) double amkpp_aDoubleObject__doubleValue;
//@property (nonatomic, readonly, assign) float amkpp_aDoubleObject__floatValue;
////@property (nonatomic, copy, readonly, nullable) id amkpp_aNumberObject;
////@property (nonatomic, copy, readonly, nullable) id amkpp_anArrayObject;
////@property (nonatomic, copy, readonly, nullable) id amkpp_aDictObject;
////@property (nonatomic, copy, readonly, nullable) id amkpp_aNullObject;
////@property (nonatomic, copy, readonly, nullable) id amkpp_aBlockObject;
////@property (nonatomic, copy, readonly, nullable) id amkpp_aCustomObject;
////@property (nonatomic, copy, readonly, nullable) id amkpp_aCustomObjectWithCustomImplementation;
//@end
//
///// 【示例2】给 NSDictionary 指定该属性协议
//@interface NSDictionary (AMKExampleDictionaryPropertiesProtocol_2) <AMKExampleDictionaryPropertiesProtocol_2>
//
//@end
