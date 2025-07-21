//
//  WKNNestedScrollTableExampleWebTableViewCell.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WKNNestedScrollTableViewCell.h"
#import "WKNNestedScrollTableViewCachedCellProtocol.h"

/// WKNNestedScrollTableView 示例：WKNNestedScrollTableViewCell 的子类，支持显示 WKWebView
@interface WKNNestedScrollTableExampleWebTableViewCell : WKNNestedScrollTableViewCell <WKNNestedScrollTableViewCachedCellProtocol>

@property (nonatomic, strong, readonly, nullable) WKWebView *webView;

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params;

@end

#pragma mark -

/// 长Web
@interface WKNNestedScrollTableExampleLongWebTableViewCell : WKNNestedScrollTableExampleWebTableViewCell

@end

#pragma mark -

/// 长Web 2
@interface WKNNestedScrollTableExampleLongWebTableViewCell2 : WKNNestedScrollTableExampleWebTableViewCell

@end

#pragma mark -

/// 短Web
@interface WKNNestedScrollTableExampleShortWebTableViewCell : WKNNestedScrollTableExampleWebTableViewCell

@end

#pragma mark -

@interface WKWebView (WKNNestedScrollTableView)

- (nullable WKNavigation *)wknNestedScrollTableView_loadHTMLStringWithContentHeight:(CGFloat)contentHeight;

@end
