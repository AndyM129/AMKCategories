//
//  NSObject+AMKERuntimeInfo.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/12/8.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AMKERuntimeInfo)
+ (void)amke_runtimeInfo;
- (void)amke_runtimeInfo;
- (void)amke_runtimeInfoForKeyPath:(NSString *_Nullable)keyPath;
@end
