#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSBundle+AMKBundleInfo.h"
#import "NSBundle+AMKGitCommitInfo.h"
#import "NSBundle+AMKAppVersionInfo.h"
#import "NSObject+AMKMethodSwizzling.h"

FOUNDATION_EXPORT double AMKCategoriesVersionNumber;
FOUNDATION_EXPORT const unsigned char AMKCategoriesVersionString[];

