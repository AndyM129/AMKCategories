//
//  AMKMJRefreshViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/11/4.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKMJRefreshViewController.h"
#import "AMKRefreshHeaderToastView.h"
#import <MJRefresh/MJRefresh.h>

@interface AMKMJRefreshViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong, nullable) UITableView *tableView;
@property (nonatomic, strong, readwrite, nullable) MJRefreshHeader *refreshHeader;
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
    self.view.backgroundColor = self.view.backgroundColor ?: [UIColor whiteColor];
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

- (MJRefreshHeader *)refreshHeader {
    if (!_refreshHeader) {
        __weak __typeof__(self)weakSelf = self;
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSInteger tag = @"toastView".hash;
                __weak AMKRefreshHeaderToastView *weakToastView = [weakSelf.tableView.mj_header viewWithTag:tag];
                if (!weakToastView) {
                    AMKRefreshHeaderToastView *toastView = [AMKRefreshHeaderToastView.alloc initWithFrame:weakSelf.tableView.mj_header.bounds];
                    toastView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                    toastView.tag = tag;
                    toastView.alpha = 0;
                    toastView.backgroundColor = weakSelf.tableView.backgroundColor;
                    [weakSelf.tableView.mj_header addSubview:toastView];
                    weakToastView = toastView;
                }
                [weakToastView show:YES animated:YES completion:^(AMKRefreshHeaderToastView * _Nonnull toastView) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.tableView.mj_header endRefreshingWithCompletionBlock:^{
                            [weakToastView show:NO animated:NO completion:nil];
                        }];
                    });
                }];
            });
        }];
    }
    return _refreshHeader;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

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

#pragma mark - Helper Methods

@end
