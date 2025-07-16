//
//  AMK10090ExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2025/7/15.
//  Copyright © 2025 AndyM129. All rights reserved.
//

#import "AMK10090ExampleViewController.h"
#import "AMK10090ExampleTableView.h"
#import "AMK10090ExampleVideoTableViewCell.h"
#import "AMK10090ExampleCategoryTitleTableViewCell.h"
#import "AMK10090ExampleTableViewCell.h"
#import "AMK10090ExampleWebViewTableViewCell.h"
#import <AMKCategories/UITableView+AMKTableViewSection.h>
#import <AMKCategories/MBProgressHUD+AMKCategories.h>

@interface AMK10090ExampleViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong, readwrite, nullable) AMK10090ExampleTableView *tableView;
@property (nonatomic, strong, readwrite, nullable) AMK10090ExampleCategoryTitleTableViewCell *categoryTitleTableViewCell;
@property (nonatomic, strong, readwrite, nullable) AMK10090ExampleWebViewTableViewCell *webViewTableViewCell;
@property (nonatomic, assign, readwrite) NSInteger categoryTitleViewSelectedIndex;
@property (nonatomic, assign) BOOL canWebViewScroll;
@end

@implementation AMK10090ExampleViewController

+ (void)load {
    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull notification) {
        [NSNotificationCenter.defaultCenter removeObserver:token];
        [UIViewController amk_pushViewController:[self new] animated:YES];
    }];
}

#pragma mark - Dealloc

- (void)dealloc {
    [_tableView removeObserverBlocks];
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor ?: [UIColor whiteColor];
    self.canWebViewScroll = NO;
    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Getters & Setters

- (AMK10090ExampleTableView *)tableView {
    if (!_tableView) {
        _tableView = [AMK10090ExampleTableView.alloc initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableFooterView = [UIView.alloc initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, CGFLOAT_MIN)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        if (@available(iOS 13.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
#           pragma clang diagnostic push
#           pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#           pragma clang diagnostic pop
        }
        [_tableView registerClass:AMK10090ExampleVideoTableViewCell.class forCellReuseIdentifier:AMK10090ExampleVideoTableViewCell.className];
        [_tableView registerClass:AMK10090ExampleCategoryTitleTableViewCell.class forCellReuseIdentifier:AMK10090ExampleCategoryTitleTableViewCell.className];
        [_tableView registerClass:AMK10090ExampleTableViewCell.class forCellReuseIdentifier:AMK10090ExampleTableViewCell.className];
        [_tableView registerClass:AMK10090ExampleWebViewTableViewCell.class forCellReuseIdentifier:AMK10090ExampleWebViewTableViewCell.className];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.className];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - Data & Networking

- (void)reloadData {
    NSMutableArray<AMKTableViewSection *> *sections = @[].mutableCopy;
    [sections addObject:({
        AMKTableViewSection *section = [AMKTableViewSection.alloc initWithIdentifier:AMK10090ExampleVideoTableViewCell.className rows:nil];
        [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleVideoTableViewCell.className userInfo:nil]];
        section;
    })];
    [sections addObject:({
        AMKTableViewSection *section = [AMKTableViewSection.alloc initWithIdentifier:AMK10090ExampleCategoryTitleTableViewCell.className rows:nil];
        [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleCategoryTitleTableViewCell.className userInfo:nil]];
        if (self.categoryTitleViewSelectedIndex == 0) {
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleWebViewTableViewCell.className userInfo:nil]];
        } else {
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
            [section.rows addObject:[AMKTableViewRow.alloc initWithIdentifier:AMK10090ExampleTableViewCell.className userInfo:nil]];
        }
        section;
    })];
    
    self.tableView.amk_sections = sections;
    [self.tableView reloadData];
}

#pragma mark - Layout Subviews

- (void)updateViewConstraints {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [super updateViewConstraints];
}

#pragma mark - Action Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableView.amk_sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AMKTableViewSection *tableViewSection = self.tableView.amk_sections[section];
    return tableViewSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof__(self)weakSelf = self;
    AMKTableViewSection *tableViewSection = self.tableView.amk_sections[indexPath.section];
    AMKTableViewRow *tableViewRow = tableViewSection.rows[indexPath.row];
    
    if ([tableViewRow.identifier isEqualToString:AMK10090ExampleVideoTableViewCell.className]) {
        AMK10090ExampleVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AMK10090ExampleVideoTableViewCell.className forIndexPath:indexPath];
        return cell;
    }
    if ([tableViewRow.identifier isEqualToString:AMK10090ExampleCategoryTitleTableViewCell.className]) {
        AMK10090ExampleCategoryTitleTableViewCell *cell = self.categoryTitleTableViewCell;
        if (!cell) {
            cell = [tableView dequeueReusableCellWithIdentifier:AMK10090ExampleCategoryTitleTableViewCell.className forIndexPath:indexPath];
            self.categoryTitleTableViewCell = cell;
        }
        cell.categoryTitleViewDidSelectItemBlock = ^(AMK10090ExampleCategoryTitleTableViewCell * _Nullable cell, NSInteger index) {
            [MBProgressHUD amk_showTextHUDWithTitle:[NSString stringWithFormat:@"点击 index = %ld", index] message:nil inView:nil responder:nil duration:1.5 animated:YES];
            weakSelf.categoryTitleViewSelectedIndex = index;
            [weakSelf reloadData];
        };
        return cell;
    }
    if ([tableViewRow.identifier isEqualToString:AMK10090ExampleTableViewCell.className]) {
        AMK10090ExampleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AMK10090ExampleTableViewCell.className forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:70/255.0 green:157/255.0 blue:227/255.0 alpha:0.5 - indexPath.row * 0.05];
        return cell;
    }
    if ([tableViewRow.identifier isEqualToString:AMK10090ExampleWebViewTableViewCell.className]) {
        AMK10090ExampleWebViewTableViewCell *cell = self.webViewTableViewCell;
        if (!cell) {
            cell = [tableView dequeueReusableCellWithIdentifier:AMK10090ExampleWebViewTableViewCell.className forIndexPath:indexPath];
            cell.webView.scrollView.delegate = self;
            cell.webView.scrollView.scrollEnabled = NO; // 先禁
            self.webViewTableViewCell = cell;
            
            UIPanGestureRecognizer *proxyPan = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
            proxyPan.delegate = self; // 这里才能写 self
            proxyPan.cancelsTouchesInView = NO; // 不抢事件
            [cell.webView.scrollView addGestureRecognizer:proxyPan];
        }
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:UITableViewCell.className forIndexPath:indexPath];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMKTableViewSection *tableViewSection = self.tableView.amk_sections[indexPath.section];
    AMKTableViewRow *tableViewRow = tableViewSection.rows[indexPath.row];

    if ([tableViewRow.identifier isEqualToString:AMK10090ExampleVideoTableViewCell.className]) {
        return [AMK10090ExampleVideoTableViewCell tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    if ([tableViewRow.identifier isEqualToString:AMK10090ExampleCategoryTitleTableViewCell.className]) {
        return [AMK10090ExampleCategoryTitleTableViewCell tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    if ([tableViewRow.identifier isEqualToString:AMK10090ExampleTableViewCell.className]) {
        return [AMK10090ExampleTableViewCell tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    if ([tableViewRow.identifier isEqualToString:AMK10090ExampleWebViewTableViewCell.className]) {
        return [AMK10090ExampleWebViewTableViewCell tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        NSLog(@"🟨 %@", scrollView);
    } else if (scrollView == self.webViewTableViewCell.webView.scrollView) {
        NSLog(@"🟩 %@", scrollView);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat threshold = self.tableView.contentSize.height - self.tableView.bounds.size.height;

        if (offsetY >= threshold) {
            scrollView.contentOffset = CGPointMake(0, threshold);
            self.canWebViewScroll = YES;
            self.webView.scrollView.scrollEnabled = YES;
        } else {
            self.canWebViewScroll = NO;
            self.webView.scrollView.scrollEnabled = NO;
        }
    }

    if (scrollView == self.webView.scrollView) {
        if (!self.canWebViewScroll) {
            scrollView.contentOffset = CGPointZero;
        }

        if (scrollView.contentOffset.y <= 0) {
            self.canWebViewScroll = NO;
            self.webView.scrollView.scrollEnabled = NO;
        }
    }
}

#pragma mark UIGestureRecognizerDelegate

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 只要两个手势里有一个来自 webView.scrollView，就允许同时识别
    if ([gestureRecognizer.view isDescendantOfView:self.webView.scrollView] || [otherGestureRecognizer.view isDescendantOfView:self.webView.scrollView]) {
        return YES;
    }
    return NO;
}

#pragma mark - Helper Methods

- (WKWebView *)webView {
    return self.webViewTableViewCell.webView;
}

@end
