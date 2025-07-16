//
//  AMK10090ExampleWebViewTableViewCell.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/15.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMK10090ExampleWebViewTableViewCell.h"
#import <AMKCategories/UIResponder+AMKUIResponderExtensionMethods.h>

@interface AMK10090ExampleWebView : WKWebView

@end

@implementation AMK10090ExampleWebView

@end

#pragma mark -
#pragma mark -

@interface AMK10090ExampleWebViewTableViewCell () <UIScrollViewDelegate>
@property (nonatomic, strong, readwrite, nullable) AMK10090ExampleWebView *webView;
@end

@implementation AMK10090ExampleWebViewTableViewCell

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.layer.borderWidth = 1 / UIScreen.mainScreen.scale;
    }
    return self;
}

#pragma mark - Getters & Setters

- (AMK10090ExampleWebView *)webView {
    if (!_webView) {
        //NSString *urlString = @"http://wenku.baidu.com";
        //NSString *urlString = @"https://m.toutiao.com";
        //NSString *urlString = @"https://tanbi.baidu.com/h5apptopic/browse/wkjumpdownload?fromKey=1027470f&docId=99b9f97b9dc3d5bbfd0a79563c1ec5da51e2d628&tfAI=0&utm_source=bdss-WKapp&utm_medium=cpc&utm_account=SS-bdtg60&e_creative=76761983588&e_keywordid=619201700996&bd_vid=7260869444029181928";
        NSString *urlString = @"https://tanbi.baidu.com/h5apptopic/browse/pptspreadact";
        NSURL *URL = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest.alloc initWithURL:URL];
        
        _webView = [AMK10090ExampleWebView.alloc init];
        _webView.scrollView.delegate = self;
        [_webView loadRequest:request];
        [self.contentView addSubview:_webView];
    }
    return _webView;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // 不调用父类实现，以避免编辑模式下的默认处理
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

+ (CGFloat)tableView:(UITableView *_Nullable)tableView heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath {
//    return MIN(tableView.bounds.size.height, UIScreen.mainScreen.bounds.size.height * 0.7);
    return tableView.bounds.size.height;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    // Clear subviews data ...
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"🔲 %@", scrollView);
    
    UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
    if (tableView) {
        CGFloat cellTop = self.frame.origin.y;
        CGFloat tableViewContentOffsetY = tableView.contentOffset.y;
        
        // 当前cell 还未露出
        if (tableViewContentOffsetY < cellTop) {
            scrollView.contentOffset = CGPointZero;
            scrollView.showsVerticalScrollIndicator = NO;
        }
        // 当前cell 已露出
        else {
            tableView.contentOffset = CGPointMake(0, cellTop);
            scrollView.showsVerticalScrollIndicator = YES;
        }
    }
}

#pragma mark - Helper Methods

@end
