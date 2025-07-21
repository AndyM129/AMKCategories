//
//  AMK10090ExampleWebViewTableViewCell.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/15.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface AMK10090ExampleWebViewTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly, nullable) UIView *webBackgroundView;

@property (nonatomic, strong, readonly, nullable) WKWebView *webView;

//+ (CGFloat)tableView:(UITableView *_Nullable)tableView heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;

@end

#pragma mark -

@interface WKWebView (WKNNestedScrollTableView)

- (nullable WKNavigation *)amk10090Example_loadHTMLStringWithContentHeight:(CGFloat)contentHeight;

@end
