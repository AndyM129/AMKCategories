//
//  NSBundle+AMKBundleInfo.h
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (AMKBundleInfo)
- (NSArray<NSDictionary *> * _Nullable)amk_bundleURLTypes;
- (NSDictionary * _Nullable)amk_bundleURLTypeWithKey:(NSString * _Nullable)key value:(id _Nullable)value;
- (NSDictionary * _Nullable)amk_bundleURLTypeWithName:(NSString * _Nullable)name;
- (NSArray<NSString *> * _Nullable)amk_bundleURLSchemesOfURLName:(NSString * _Nullable)bundleURLName;
@end

NS_ASSUME_NONNULL_END
