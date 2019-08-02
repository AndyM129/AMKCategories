//
//  NSBundle+AMKBundleInfo.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 2019/8/3.
//

#import "NSBundle+AMKBundleInfo.h"

@implementation NSBundle (AMKBundleInfo)

#pragma mark - Init Methods

#pragma mark - Properties

#pragma mark - Public Methods

- (NSArray<NSDictionary *> *)amk_bundleURLTypes {
    NSArray *bundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    if ([bundleURLTypes isKindOfClass:NSArray.class]) {
        return bundleURLTypes;
    } else {
        return nil;
    }
}

- (NSDictionary *)amk_bundleURLTypeWithKey:(NSString *)key value:(id)value {
    NSDictionary *bundleURLType = nil;
    NSArray<NSDictionary *> *bundleURLTypes = [self amk_bundleURLTypes];
    for (NSDictionary *currentBundleURLType in bundleURLTypes) {
        if (currentBundleURLType && [currentBundleURLType isKindOfClass:[NSDictionary class]]) {
            id object = [currentBundleURLType objectForKey:key];
            if (object && [object isEqual:value]) {
                bundleURLType = currentBundleURLType;
                break;
            }
        }
    }
    return bundleURLType;
}

- (NSDictionary *)amk_bundleURLTypeWithName:(NSString *)name {
    NSDictionary *bundleURLType = [self amk_bundleURLTypeWithKey:@"CFBundleURLName" value:name];
    return [bundleURLType isKindOfClass:NSDictionary.class] ? bundleURLType : nil;;
}

- (NSArray<NSString *> * _Nullable)amk_bundleURLSchemesOfURLName:(NSString * _Nullable)bundleURLName {
    NSArray *bundleURLSchemes = nil;
    NSDictionary *bundleURLType = [self amk_bundleURLTypeWithKey:@"CFBundleURLName" value:bundleURLName];
    if (bundleURLType && [bundleURLType isKindOfClass:NSDictionary.class]) {
        bundleURLSchemes = [bundleURLType objectForKey:@"CFBundleURLSchemes"];
    }
    return bundleURLSchemes;
}

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Networking

#pragma mark - Helper Methods


@end
