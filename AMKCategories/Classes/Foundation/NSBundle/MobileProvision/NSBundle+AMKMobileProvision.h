//
//  NSBundle+AMKMobileProvision.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2020/5/9.
//

#import <Foundation/Foundation.h>

/// MobileProvision 信息获取
@interface NSBundle (AMKMobileProvision)

/// 证书文件路径
@property(nullable, readonly, copy) NSString *amk_mobileProvisionPath;

/// 证书内容信息
@property(nullable, readonly, copy) NSDictionary<NSString *, id> *amk_mobileProvisionInfoDictionary;

@end
