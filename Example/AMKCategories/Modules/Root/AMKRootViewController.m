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
//    [self test_1];
    [self test_2];
    [self test_3];
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
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKBundleResourceRequestExampleViewController" title:@"ODR：On-Demand Resources (iOS, tvOS) 调研" detail:@"iOS 官方包体积优化方案"]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKAiRootController" title:@"AIGC" detail:nil]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKCustomTransitioningViewController" title:@"自定义转场" detail:nil]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKScreenRightEdgePanGestureRecognizerExampleViewController" title:@"屏幕右侧边缘手势 示例" detail:nil]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMK8250MainWebViewController" title:@"WKWebView 长按选中文字 选区控制 示例" detail:nil]];
        [_examples addObject:[AMKRootExampleModel.alloc initWithClazzName:@"AMKCategories_Example.AMKSubStringViewController" title:@"【Swift】SubString 相关处理" detail:nil]];
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

- (void)test_1 {
    UIView *view = [UIView.alloc init];
    view.frame = CGRectMake(0, 0, 200, 200);
    view.center = self.view.center;
//    view.layer.backgroundColor = UIColor.grayColor.CGColor;
    [self.view addSubview:view];
    
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformRotate(transform, -M_PI_2);
//    CGAffineTransform transform2 = CGAffineTransformIdentity;
//    transform2 = CGAffineTransformScale(transform2, .5, .5);
//
//    CGPathAddRect(path,&transform , CGRectMake(-50, rect.size.height-110, 100, 100));
//    CGPathAddRect(path, &transform2, CGRectMake(150, rect.size.height-110, 100, 100));
//    CGContextAddPath(context, path);
//    CGContextSetLineWidth(context, 3);
//    CGContextDrawPath(context, kCGPathStroke);
//    CGPathRelease(path);

//    CAShapeLayer *layerMask = [CAShapeLayer layer];
//    layerMask.frame = self.bounds;
//    layerMask.path = [UIBezierPath bezierPathWithRoundedRect:layerMask.frame cornerRadius:12].CGPath;
//    self.layer.mask = layerMask;



    
    [view.layer addSublayer:({
        CGSize finalSize = CGSizeMake(150, 150);
        CGFloat layerHeight = finalSize.height * 0.2;
        
        UIBezierPath *path = [[UIBezierPath alloc]init];
        [path moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
        [path addLineToPoint:CGPointMake(0, finalSize.height - 1)];
        [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height - 1)];
        [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height - layerHeight)];
        [path addQuadCurveToPoint:CGPointMake(0, finalSize.height - layerHeight) controlPoint:CGPointMake(finalSize.width / 2, (finalSize.height - layerHeight) - 40)];

        CAShapeLayer *bottomCurveLayer = [[CAShapeLayer alloc]init];
        bottomCurveLayer.path = path.CGPath;
        bottomCurveLayer.fillColor = [UIColor orangeColor].CGColor;
        bottomCurveLayer;
    })];

}

- (void)test_2 {
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(29, NSNotFound, 29, NSNotFound);
    CGRect frame = CGRectMake(0, edgeInsets.top, 102, UIScreen.mainScreen.bounds.size.height - edgeInsets.top - edgeInsets.bottom);
    frame.origin.x = UIScreen.mainScreen.bounds.size.width - frame.size.width;
    
    UIView *rightScreenEdgeNewEditorGuideView = [UIView.alloc initWithFrame:frame];
    [rightScreenEdgeNewEditorGuideView.layer addSublayer:({
        UIBezierPath *path = [UIBezierPath.alloc init];
        [path moveToPoint:CGPointMake(frame.size.width, 0)];
        [path addQuadCurveToPoint:CGPointMake(frame.size.width, frame.size.height) controlPoint:CGPointMake(-frame.size.width, frame.size.height / 2)];

        CAShapeLayer *backgroundLayer = [CAShapeLayer.alloc init];
        backgroundLayer.path = path.CGPath;
        backgroundLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.4].CGColor;
        backgroundLayer;
    })];
    [UIApplication.sharedApplication.delegate.window addSubview:rightScreenEdgeNewEditorGuideView];
}

- (void)test_3 {
    CGRect frame = CGRectMake(0, 0, 68, 168);
    frame.origin.x = UIScreen.mainScreen.bounds.size.width - frame.size.width;
    frame.origin.y = (UIScreen.mainScreen.bounds.size.height - frame.size.height) / 2;
    
    UIView *rightScreenEdgeNewEditorView = [UIView.alloc initWithFrame:frame];
    [rightScreenEdgeNewEditorView.layer addSublayer:({
        UIBezierPath *path = [UIBezierPath.alloc init];
        [path moveToPoint:CGPointMake(frame.size.width, 0)];
        [path addQuadCurveToPoint:CGPointMake(frame.size.width, frame.size.height) controlPoint:CGPointMake(-frame.size.width, frame.size.height / 2)];

        CAShapeLayer *backgroundLayer = [CAShapeLayer.alloc init];
        backgroundLayer.path = path.CGPath;
        backgroundLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.3].CGColor;
        backgroundLayer;
    })];
    [UIApplication.sharedApplication.delegate.window addSubview:rightScreenEdgeNewEditorView];
}

@end
