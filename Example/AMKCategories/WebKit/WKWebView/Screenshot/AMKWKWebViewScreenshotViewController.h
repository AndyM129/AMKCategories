//
//  AMKWKWebViewScreenshotViewController.h
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2020/4/27.
//  Copyright © 2020 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMKWKWebViewScreenshotViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

@interface WKWebView (YYAdd)

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)snapshotImage;

@end
