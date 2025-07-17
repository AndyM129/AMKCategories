//
//  WKNNestedScrollTableExampleWebTableViewCell.h
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/17.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WKNNestedScrollTableExampleWebTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly, nullable) WKWebView *webView;

+ (CGFloat)tableView:(nullable UITableView *)tableView heightForRowAtIndexPath:(nullable NSIndexPath *)indexPath withParams:(nullable id)params;

@end
