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

//@interface AMK10090ExampleWebViewTableViewCell () <UIScrollViewDelegate>
//@property (nonatomic, strong, readwrite, nullable) UIView *webBackgroundView;
//@property (nonatomic, assign, readwrite) CGFloat contentHeight;
//@property (nonatomic, strong, readwrite, nullable) MASConstraint *contentHeightConstraint;
//@property (nonatomic, strong, readwrite, nullable) WKWebView *webView;
//@end
//
//@implementation AMK10090ExampleWebViewTableViewCell
//
//#pragma mark - Init Methods
//
//- (void)dealloc {
//    [_webView.scrollView removeObserverBlocks];
//}
//
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.contentView.layer.borderWidth = 1 / UIScreen.mainScreen.scale;
////        self.contentHeight = 100;
////        
////        _webBackgroundView = [UIView.alloc init];
////        _webBackgroundView.backgroundColor = [UIColor.yellowColor colorWithAlphaComponent:0.1];
////        [self.contentView addSubview:_webBackgroundView];
////        [_webBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.left.top.right.equalTo(self.contentView);
////            self.contentHeightConstraint = make.height.mas_equalTo(self.contentHeight); // 默认高度
////            make.bottom.equalTo(self.contentView); // ⚠️ 关键：撑开 contentView
////        }];
////        
////        __weak __typeof__(self)weakSelf = self;
////        [_webBackgroundView addGestureRecognizer:[UITapGestureRecognizer.alloc initWithActionBlock:^(id  _Nonnull sender) {
////            weakSelf.contentHeight = arc4random() % 400;
////        }]];
//        
//        self.webBackgroundView = [UIView new];
//        self.webBackgroundView.backgroundColor = [UIColor.yellowColor colorWithAlphaComponent:0.1];
//        [self.contentView addSubview:self.webBackgroundView];
//        
//        [self.webBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.equalTo(self.contentView);
//            self.contentHeightConstraint = make.height.mas_equalTo(100); // 默认高度
//            make.bottom.equalTo(self.contentView); // ⚠️ 关键：撑开 contentView
//        }];
//        
//        __weak __typeof__(self)weakSelf = self;
//        [_webBackgroundView addGestureRecognizer:[UITapGestureRecognizer.alloc initWithActionBlock:^(id  _Nonnull sender) {
//            weakSelf.contentHeight = arc4random() % 400;
//        }]];
//    }
//    return self;
//}
//
//#pragma mark - Getters & Setters
//
////- (UIView *)webBackgroundView {
////    if (!_webBackgroundView) {
////        _webBackgroundView = [UIView.alloc init];
////        _webBackgroundView.backgroundColor = [UIColor.yellowColor colorWithAlphaComponent:0.1];
////        [self.contentView addSubview:_webBackgroundView];
////        [_webBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.left.top.right.equalTo(self.contentView);
////            self.contentHeightConstraint = make.height.mas_equalTo(self.contentHeight); // 默认高度
////            make.bottom.equalTo(self.contentView); // ⚠️ 关键：撑开 contentView
////        }];
////        
////        __weak __typeof__(self)weakSelf = self;
////        [_webBackgroundView addGestureRecognizer:[UITapGestureRecognizer.alloc initWithActionBlock:^(id  _Nonnull sender) {
////            weakSelf.contentHeight = arc4random() % 400;
////        }]];
////    }
////    return _webBackgroundView;
////}
////
////- (void)setContentHeight:(CGFloat)contentHeight {
////    _contentHeight = contentHeight;
////    if (_contentHeightConstraint) {
////        _contentHeightConstraint.mas_equalTo(_contentHeight);
////    }
////    [self setNeedsUpdateConstraints];
////    [self updateConstraintsIfNeeded];
////}
//
//- (void)setContentHeight:(CGFloat)contentHeight {
////    self.contentHeightConstraint.mas_equalTo(contentHeight);
////    [self setNeedsUpdateConstraints];
////    [self updateConstraintsIfNeeded];
//    
//    [self.contentHeightConstraint uninstall]; // ⚠️ 注意更新前先卸载旧的
//    [self.webBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
//        self.contentHeightConstraint = make.height.mas_equalTo(contentHeight);
//    }];
//    
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
//}
//
////- (WKWebView *)webView {
////    if (!_webView) {
////        __weak __typeof__(self)weakSelf = self;
////        _webView = [WKWebView.alloc init];
////        _webView.scrollView.delegate = self;
////        [_webView.scrollView addObserverBlockForKeyPath:@"contentSize" block:^(UIScrollView * _Nonnull scrollView, NSNumber * oldVal, NSNumber * newVal) {
////            if (!CGSizeEqualToSize(newVal.CGSizeValue, oldVal.CGSizeValue)) {
////                [weakSelf setNeedsUpdateConstraints];
////                [weakSelf updateConstraintsIfNeeded];
////                
//////                dispatch_async(dispatch_get_main_queue(), ^{
//////                    UITableView *tableView = [weakSelf amk_nextResponderWithClass:UITableView.class];
//////                    [tableView beginUpdates];
//////                    [tableView endUpdates];
//////                });
////            }
////        }];
////        [self.contentView addSubview:_webView];
////    }
////    return _webView;
////}
//
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    // 不调用父类实现，以避免编辑模式下的默认处理
//}
//
//#pragma mark - Data & Networking
//
//#pragma mark - Layout Subviews
//
//+ (CGFloat)tableView:(UITableView *_Nullable)tableView heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath {
//    return UITableViewAutomaticDimension;
//}
//
//+ (BOOL)requiresConstraintBasedLayout {
//    return YES;
//}
//
//- (void)updateConstraints {
//    
//    
////    [self.webBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
////        make.left.top.right.mas_equalTo(self.contentView);
////        make.height.mas_equalTo(self.contentHeight);
////        make.bottom.mas_equalTo(self.contentView);
////    }];
//    
////    [self.webBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(self.contentView).inset(11);
////        make.height.mas_equalTo(240);
////        make.left.mas_equalTo(self.contentView).inset(70);
////        make.right.mas_lessThanOrEqualTo(self.contentView).inset(20);
////        make.bottom.mas_equalTo(self.contentView);
////    }];
//    
////    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
////        make.left.right.mas_equalTo(self.contentView);
////        make.top.mas_equalTo(self.contentView);
////        make.height.mas_equalTo(100);//(MAX(100, self.webView.scrollView.contentSize.height));
////        make.bottom.mas_equalTo(self.contentView);
////    }];
//    
//    //according to apple super should be called at end of method
//    [super updateConstraints];
//}
//
//- (void)prepareForReuse {
//    [super prepareForReuse];
//    // Clear subviews data ...
//}
//
//#pragma mark - Action Methods
//
//#pragma mark - Notifications
//
//#pragma mark - KVO
//
//#pragma mark - Protocol
//
//#pragma mark UIScrollViewDelegate
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
////    NSLog(@"🔲 %@", scrollView);
////    
////    UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
////    if (tableView) {
////        CGFloat cellTop = self.frame.origin.y;
////        CGFloat tableViewContentOffsetY = tableView.contentOffset.y;
////        
////        // 当前cell 还未露出
////        if (tableViewContentOffsetY < cellTop) {
////            scrollView.contentOffset = CGPointZero;
////            scrollView.showsVerticalScrollIndicator = NO;
////        }
////        // 当前cell 已露出
////        else {
////            scrollView.showsVerticalScrollIndicator = YES;
////        }
////    }
//}
//
//#pragma mark - Helper Methods
//
//@end

@interface AMKWebBackgroundView : UIView
@property (nonatomic, assign, readwrite) CGFloat customIntrinsicContentHeight;
@end

@implementation AMKWebBackgroundView

- (void)setCustomIntrinsicContentHeight:(CGFloat)customIntrinsicContentHeight {
    NSLog(@"%g -> %g", _customIntrinsicContentHeight, customIntrinsicContentHeight);
    _customIntrinsicContentHeight = customIntrinsicContentHeight;
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    CGSize intrinsicContentSize = [super intrinsicContentSize];
    intrinsicContentSize.height = self.customIntrinsicContentHeight;
    return intrinsicContentSize;
}

@end


@interface AMK10090ExampleWebViewTableViewCell ()
@property (nonatomic, strong) AMKWebBackgroundView *webBackgroundView;
@property (nonatomic, strong) MASConstraint *heightConstraint;
@end

@implementation AMK10090ExampleWebViewTableViewCell

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.webBackgroundView = [AMKWebBackgroundView new];
        self.webBackgroundView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.webBackgroundView];

        [self.webBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        
        __weak __typeof__(self)weakSelf = self;
        [self.webBackgroundView addGestureRecognizer:[UITapGestureRecognizer.alloc initWithActionBlock:^(id  _Nonnull sender) {
            //[weakSelf setWebHeight:arc4random() % 400 + 50];
            weakSelf.webBackgroundView.customIntrinsicContentHeight = arc4random() % 400 + 50;
            [weakSelf setNeedsUpdateConstraints];
            [weakSelf updateConstraintsIfNeeded];
            
            UITableView *tableView = [weakSelf amk_nextResponderWithClass:UITableView.class];
            [tableView beginUpdates];
            [tableView endUpdates];
        }]];
    }
    return self;
}

- (void)setWebHeight:(CGFloat)height {
//    [self.heightConstraint uninstall]; // ⚠️ 注意更新前先卸载旧的
//    [self.webBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
//        self.heightConstraint = make.height.mas_equalTo(height);
//    }];

//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
//    
//    UITableView *tableView = [self amk_nextResponderWithClass:UITableView.class];
//    [tableView beginUpdates];
//    [tableView endUpdates];
}

@end
