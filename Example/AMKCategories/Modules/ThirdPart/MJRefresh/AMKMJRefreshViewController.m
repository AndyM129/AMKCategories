//
//  AMKMJRefreshViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/11/4.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKMJRefreshViewController.h"
#import "AMKRefreshHeader.h"

@interface AMKMJRefreshViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong, nullable) UITableView *tableView;
@property (nonatomic, strong, readwrite, nullable) AMKRefreshHeader *refreshHeader;
@end

@implementation AMKMJRefreshViewController

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSStringFromClass(self.class);
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadBarButtonItemClicked:)];
    self.view.backgroundColor = self.view.backgroundColor ?: [UIColor whiteColor];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.tableView.mj_header beginRefreshing];
    });
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
        _tableView.mj_header = self.refreshHeader;
        _tableView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (AMKRefreshHeader *)refreshHeader {
    if (!_refreshHeader) {
        __weak __typeof__(self)weakSelf = self;
        _refreshHeader = [AMKRefreshHeader headerWithRefreshingBlock:^{
            NSLog(@"刷新场景：%ld", weakSelf.refreshHeader.scene);
            [weakSelf.refreshHeader performSelector:@selector(endRefreshing) afterDelay:0.5];
        }];
        [_refreshHeader setWillEndRefreshingBlock:^NSTimeInterval(AMKRefreshHeader * _Nullable refreshHeader) {
            refreshHeader.toastView.titleLabel.text = [NSString stringWithFormat:@"测试：为您推荐%u条新内容", (arc4random()%20 + 5)];
            return 1.0;
        }];
    }
    return _refreshHeader;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (void)reloadBarButtonItemClicked:(id)sender {
    [(AMKRefreshHeader *)self.tableView.mj_header beginRefreshingWithScene:AMKRefreshSceneReloadBarButtonItemClicked completionBlock:nil];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.2];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [(AMKRefreshHeader *)self.tableView.mj_header beginRefreshingWithScene:AMKRefreshSceneTableViewCellClicked completionBlock:nil];
}

#pragma mark - Helper Methods

@end
