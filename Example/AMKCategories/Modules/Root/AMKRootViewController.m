//
//  AMKRootViewController.m
//  AMKCategories
//
//  Created by https://github.com/andym129 on 07/26/2019.
//  Copyright (c) 2019 AndyM129. All rights reserved.
//

#import "AMKRootViewController.h"
#import "AMKRootExampleModel.h"

@interface AMKRootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong, nullable) UITableView *tableView;
@property (nonatomic, strong, readwrite, nullable) NSMutableArray<AMKRootExampleModel *> *examples;
@end

@implementation AMKRootViewController

#pragma mark - Life Circle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AMKCategories";
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView reloadData];
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

#pragma mark - Properties

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self.navigationController.navigationBar setNeedsLayout];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView.alloc initWithFrame:self.view.bounds style:UITableViewStylePlain];
        if (@available(iOS 13.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray<AMKRootExampleModel *> *)examples {
    if (!_examples) {
        _examples = @[].mutableCopy;
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKGitCommitInfoViewController" title:@"Git提交信息"]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKContentHuggingPriorityViewController" title:@"UIView：抗拉伸 / 抗压缩"]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKOfflineLoadingWebViewController" title:@"WebView：离线加载"]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKMJRefreshViewController" title:@"MJRefresh：为您推荐xx条新内容" detail:@"类似头条，下拉刷新时结束之前，会先显示「为您推荐xx条新内容」"]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKUIPasteboardAlertExampleViewController" title:@"UIPasteboard：iOS16+ 权限弹窗优化" detail:@""]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKLottieExampleViewController" title:@"Lottie 动画示例" detail:@""]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKLifeCircleTabBarController" title:@"TabBarController viewDidAppear 探索" detail:@""]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKStackViewController" title:@"示例" detail:@"这是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述"]];
    }
    return _examples;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMKRootExampleModel *example = self.examples[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.className];
    if (!cell) cell = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:UITableViewCell.className];
    cell.textLabel.text = example.title;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = example.detail;
    cell.detailTextLabel.textColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0];
    return cell;
}

#pragma mark UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AMKRootExampleModel *example = self.examples[indexPath.row];
    [UIViewController amk_pushViewController:[NSClassFromString(example.clazzName) new] animated:YES];
}

#pragma mark - Override

#pragma mark - Helper Methods

@end
