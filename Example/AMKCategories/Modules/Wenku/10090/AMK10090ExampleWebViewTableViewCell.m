//
//  AMK10090ExampleWebViewTableViewCell.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/15.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMK10090ExampleWebViewTableViewCell.h"
#import <AMKCategories/UIResponder+AMKUIResponderExtensionMethods.h>

@implementation WKWebView (WKNNestedScrollTableView)

- (nullable WKNavigation *)amk10090Example_loadHTMLStringWithContentHeight:(CGFloat)contentHeight {
    NSString *htmlString = @"<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Gradient Background</title><style>body,html{margin:0;padding:0;}.gradient-container{display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;width:100%;height:321px;background:linear-gradient(to bottom,#6ec89f,#6895da)}.gradient-container p{display:block}</style></head><body><div class=\"gradient-container\">这是 WebView，内容高度 321px</div></body></html>";
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"321px" withString:[NSString stringWithFormat:@"%.0fpx", contentHeight]];
    return [self loadHTMLString:htmlString baseURL:nil];
}

@end

#pragma mark -
#pragma mark -

@interface _AMK10090ExampleIntrinsicSizeView : UIView
@property (nonatomic, assign, readwrite) CGFloat intrinsicContentHeight;
@end

@implementation _AMK10090ExampleIntrinsicSizeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setIntrinsicContentHeight:(CGFloat)intrinsicContentHeight {
    if (_intrinsicContentHeight == intrinsicContentHeight) {
        return;
    }
    
    NSLog(@"%g -> %g", _intrinsicContentHeight, intrinsicContentHeight);
    _intrinsicContentHeight = intrinsicContentHeight;
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    CGSize intrinsicContentSize = [super intrinsicContentSize];
    intrinsicContentSize.height = self.intrinsicContentHeight;
    return intrinsicContentSize;
}

@end

#pragma mark -
#pragma mark -

@interface AMK10090ExampleWebViewTableViewCell () <UIScrollViewDelegate>
@property (nonatomic, strong, readwrite, nullable) _AMK10090ExampleIntrinsicSizeView *intrinsicSizeView;
@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
@end

@implementation AMK10090ExampleWebViewTableViewCell

#pragma mark - Init Methods

- (void)dealloc {
    [_webView.scrollView removeObserverBlocks];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.layer.borderWidth = 1 / UIScreen.mainScreen.scale;
    }
    return self;
}

#pragma mark - Getters & Setters

- (_AMK10090ExampleIntrinsicSizeView *)intrinsicSizeView {
    if (!_intrinsicSizeView) {
        _intrinsicSizeView = [_AMK10090ExampleIntrinsicSizeView.alloc init];
        _intrinsicSizeView.intrinsicContentHeight = 50;
        [self.contentView insertSubview:_intrinsicSizeView atIndex:0];
    }
    return _intrinsicSizeView;
}

- (WKWebView *)webView {
    if (!_webView) {
        __weak __typeof__(self)weakSelf = self;
        _webView = [WKWebView.alloc init];
        _webView.scrollView.delegate = self;
        _webView.layer.borderColor = [UIColor.redColor colorWithAlphaComponent:0.5].CGColor;
        _webView.layer.borderWidth = 3;
        [_webView.scrollView addObserverBlockForKeyPath:@"contentSize" block:^(UIScrollView * _Nonnull scrollView, NSNumber * oldVal, NSNumber * newVal) {
            if (!CGSizeEqualToSize(newVal.CGSizeValue, oldVal.CGSizeValue)) {
                [UIView performWithoutAnimation:^{
                    [weakSelf setNeedsUpdateConstraints];
                    [weakSelf updateConstraintsIfNeeded];

                    weakSelf.intrinsicSizeView.intrinsicContentHeight = scrollView.contentSize.height;
                    UITableView *tableView = [weakSelf amk_nextResponderWithClass:UITableView.class];
                    [tableView performBatchUpdates:nil completion:nil];
                }];
            }
        }];
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
    return UITableViewAutomaticDimension;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.intrinsicSizeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
        make.left.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(MIN(tableView.height, self.webView.scrollView.contentSize.height));
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
//    NSLog(@"🔲 %@", scrollView);
    
    UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
    if (tableView) {
        CGFloat cellTop = self.frame.origin.y;
        CGFloat tableViewContentOffsetY = tableView.contentOffset.y;
        NSLog(@"🔲 cellTop = %g, tableViewContentOffsetY = %g, Y-Top差值 = %g", cellTop, tableViewContentOffsetY, tableViewContentOffsetY - cellTop);
        
        CGFloat webViewTop = MAX(0, (tableViewContentOffsetY - cellTop));
        webViewTop = MIN(webViewTop, scrollView.contentSize.height - scrollView.height);
        self.webView.top = webViewTop;
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewTop);
    }
}

#pragma mark - Helper Methods

@end




//@interface AMK10090ExampleWebViewTableViewCell ()
//@property (nonatomic, strong) _AMK10090ExampleIntrinsicSizeView *webBackgroundView;
//@end
//
//@implementation AMK10090ExampleWebViewTableViewCell
//
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        __weak __typeof__(self)weakSelf = self;
//        self.contentView.backgroundColor = [UIColor.yellowColor colorWithAlphaComponent:0.1];
//        [self.contentView addGestureRecognizer:[UITapGestureRecognizer.alloc initWithActionBlock:^(id  _Nonnull sender) {
//            weakSelf.webBackgroundView.intrinsicContentHeight = arc4random() % 400 + 50;
////            [weakSelf setNeedsUpdateConstraints];
////            [weakSelf updateConstraintsIfNeeded];
//            
//            UITableView *tableView = [weakSelf amk_nextResponderWithClass:UITableView.class];
//            [UIView performWithoutAnimation:^{
//                [tableView performBatchUpdates:nil completion:nil];
//            }];
////            [tableView performBatchUpdates:nil completion:nil];
////            [tableView beginUpdates];
////            [tableView endUpdates];
//        }]];
//    }
//    return self;
//}
//
//- (_AMK10090ExampleIntrinsicSizeView *)webBackgroundView {
//    if (!_webBackgroundView) {
//        _webBackgroundView = [_AMK10090ExampleIntrinsicSizeView new];
//        _webBackgroundView.hidden = YES;
//        _webBackgroundView.backgroundColor = [UIColor greenColor];
//        _webBackgroundView.intrinsicContentHeight = 200;
//        [self.contentView addSubview:_webBackgroundView];
//    }
//    return _webBackgroundView;
//}
//
//+ (BOOL)requiresConstraintBasedLayout {
//    return YES;
//}
//
//- (void)updateConstraints {
//    [self.webBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView);
//    }];
//    
//    //according to apple super should be called at end of method
//    [super updateConstraints];
//}
//
//@end
