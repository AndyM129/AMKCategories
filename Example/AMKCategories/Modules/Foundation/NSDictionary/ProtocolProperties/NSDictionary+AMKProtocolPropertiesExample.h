//
//  NSDictionary+AMKProtocolPropertiesExample.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/9/5.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <AMKCategories/NSDictionary+AMKProtocolProperties.h>

#pragma mark - 需要考虑的类型
NS_ASSUME_NONNULL_BEGIN

@interface AMKCustomObject : NSObject @end

@protocol AMKExampleDictionaryAllPropertiesProtocol <NSObject>
// 基础数据类型，参考自 NSNumber
@property char charValue;
@property unsigned char unsignedCharValue;
@property short shortValue;
@property unsigned short unsignedShortValue;
@property int intValue;
@property unsigned int unsignedIntValue;
@property long longValue;
@property unsigned long unsignedLongValue;
@property long long longLongValue;
@property unsigned long long unsignedLongLongValue;
@property float floatValue;
@property double doubleValue;
@property BOOL boolValue;
@property NSInteger integerValue;
@property NSUInteger unsignedIntegerValue;
// 基础数据类型，参考自 NSValue (NSValueUIGeometryExtensions)
@property CGPoint CGPointValue;
@property CGVector CGVectorValue;
@property CGSize CGSizeValue;
@property CGRect CGRectValue;
@property CGAffineTransform CGAffineTransformValue;
@property UIEdgeInsets UIEdgeInsetsValue;
@property NSDirectionalEdgeInsets directionalEdgeInsetsValue;
@property UIOffset UIOffsetValue;
// 对象类型
@property NSString *stringValue;
// 其他对象类型
@property NSData *dataValue;
@property NSURL *URLValue;
@property NSDate *dateValue;
@property NSArray *arrayValue;
@property NSDictionary *dictionaryValue;
// 自定义对象类型
@property AMKCustomObject *customObject;
@end

NS_ASSUME_NONNULL_END

#pragma mark - 示例1

/// 【示例1】在协议中声明 xxx 字典中 key 对应的「只读属性」，以便支持直接通过属性访问对应Key值
@protocol AMKExampleDictionaryPropertiesProtocol_1 <NSObject>
@optional
@property (nonatomic, readonly, nullable) id amkpp_aStringObject;
@property (nonatomic, readonly, nullable) id amkpp_aIntegerObject;
@property (nonatomic, readonly, nullable) id amkpp_aBoolObject;
@property (nonatomic, readonly, nullable) id amkpp_aDoubleObject;
@property (nonatomic, readonly, nullable) id amkpp_aNumberObject;
@property (nonatomic, readonly, nullable) id amkpp_anArrayObject;
@property (nonatomic, readonly, nullable) id amkpp_aDictObject;
@property (nonatomic, readonly, nullable) id amkpp_aNullObject;
@property (nonatomic, readonly, nullable) id amkpp_aBlockObject;
@property (nonatomic, readonly, nullable) id amkpp_aCustomObject;
@property (nonatomic, readonly, nullable) id amkpp_aCustomObjectWithCustomImplementation;
@end

#pragma mark - 示例2

/// 【示例2】在协议中声明 xxx 字典中 key 对应的「读写属性」，以便支持直接通过属性访问对应Key值
@protocol AMKExampleDictionaryPropertiesProtocol_2 <NSObject>
@optional
@property (nonatomic, readwrite, nullable) id amkpp_aStringObject;
@property (nonatomic, readwrite, nullable) id amkpp_aIntegerObject;
@property (nonatomic, readwrite, nullable) id amkpp_aBoolObject;
@property (nonatomic, readwrite, nullable) id amkpp_aDoubleObject;
@property (nonatomic, readwrite, nullable) id amkpp_aNumberObject;
@property (nonatomic, readwrite, nullable) id amkpp_anArrayObject;
@property (nonatomic, readwrite, nullable) id amkpp_aDictObject;
@property (nonatomic, readwrite, nullable) id amkpp_aNullObject;
@property (nonatomic, readwrite, nullable) id amkpp_aBlockObject;
@property (nonatomic, readwrite, nullable) id amkpp_aCustomObject;
@property (nonatomic, readwrite, nullable) id amkpp_aCustomObjectWithCustomImplementation;
@end

//#pragma mark - 示例9
//
///// 【示例2】在协议中声明 xxx 字典中 key 对应的属性，以便支持直接通过属性访问对应Key值
//@protocol AMKExampleDictionaryPropertiesProtocol_9 <NSObject>
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
//@interface NSDictionary (AMKExampleDictionaryPropertiesProtocol_9) <AMKExampleDictionaryPropertiesProtocol_9>
//
//@end
