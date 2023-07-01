//
//  AMKAiWebViewController.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/5/24.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMKAiWebViewController : UIViewController

@property (nonatomic, copy, readwrite, nullable) NSString *url;

- (instancetype _Nullable)initWithUrl:(NSString *_Nullable)url;
- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title;

@end
