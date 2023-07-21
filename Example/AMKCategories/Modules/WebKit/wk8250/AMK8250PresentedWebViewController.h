//
//  AMK8250PresentedWebViewController.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/7/21.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMK8250PresentedWebViewController : UIViewController

- (BOOL)presentFromViewController:(UIViewController *_Nullable)fromViewController animated:(BOOL)animated completion:(void (^_Nullable)(UIViewController *_Nullable viewController))completion;

@end
