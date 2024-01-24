//
//  AMK8330ExampleViewController.m
//  AMKCategories_Example
//
//  Created by Meng Xinxin on 2023/12/27.
//  Copyright © 2023 AndyM129. All rights reserved.
//

#import "AMK8330ExampleViewController.h"
#import "AMK8330ExampleWebView.h"
#import <AMKCategories/MBProgressHUD+AMKCategories.h>

@interface GradientTransparentView : UIView

@end

@implementation GradientTransparentView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 开始图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 使用RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // 设置半透明黑色
    UIColor *blackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    UIColor *clearColor = [UIColor clearColor];
    
    // 设置颜色数组（此处为开始颜色和结束颜色）
    NSArray *colors = @[(__bridge id)blackColor.CGColor, (__bridge id)clearColor.CGColor];
    
    // 设置颜色分布位置（0为起点，1为终点）
    const CGFloat locations[] = {0.0, 1.0};
    
    // 创建渐变
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    
    // 设置渐变区域并绘制渐变效果
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) / 2;
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    // 释放颜色空间和渐变对象
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

@end


@interface AMK8330ExampleViewController ()
@property (nonatomic, strong, readwrite, nullable) AMK8330ExampleWebView *webView;
@end

@implementation AMK8330ExampleViewController

//+ (void)load {
//    id __block token = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
//        [NSNotificationCenter.defaultCenter removeObserver:token];
//        [UIViewController amk_pushViewController:self.new animated:YES];
//    }];
//}

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

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"reload" style:UIBarButtonItemStylePlain target:self action:@selector(reloadCustomMenuItems:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"reload" style:UIBarButtonItemStylePlain target:self action:@selector(spotlightView)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://readme.so/editor"]]];
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

- (AMK8330ExampleWebView *)webView {
    if (!_webView) {
        _webView = [AMK8330ExampleWebView.alloc init];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _webView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Action Methods

- (void)reloadCustomMenuItems:(id)sender {
    //[self.webView becomeFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIMenuController.sharedMenuController.menuItems = @[
            [UIMenuItem.alloc initWithTitle:[NSString stringWithFormat:@"%d", arc4random()%100] action:@selector(didClickCustomMenuItem:)],
        ];
        [UIMenuController.sharedMenuController update];
        [MBProgressHUD amk_showTextHUDWithTitle:@"ClickCustomMenuItem" message:[sender description] inView:nil responder:nil duration:3 animated:YES];
    });
}

- (void)didClickCustomMenuItem:(id)sender {
    [MBProgressHUD amk_showTextHUDWithTitle:@"ClickCustomMenuItem" message:[sender description] inView:nil responder:nil duration:3 animated:YES];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

- (void)spotlightView {
    // 创建半透明黑色视图
    UIView *translucentBlackView = [[UIView alloc] initWithFrame:self.view.bounds];
    translucentBlackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:translucentBlackView];

    // 创建渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 100, 200, 100);

    // 设置渐变色
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                             (__bridge id)[UIColor blackColor].CGColor,
                             (__bridge id)[UIColor blackColor].CGColor,
                             (__bridge id)[UIColor clearColor].CGColor];

    // 设置渐变色的分布区间，0表示开始，1表示结束
    gradientLayer.locations = @[@0.0, @1.0];

    // 设置渐变的方向
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);

//    // 创建一个遮罩层，这里简单使用和translucentBlackView一样大小的层
//    CALayer *maskLayer = [CALayer layer];
//    maskLayer.frame = translucentBlackView.bounds;
//
//    // 将渐变层设置为遮罩层的背景
//    [maskLayer addSublayer:gradientLayer];

    // 将遮罩层设置到半透明视图的layer.mask上
    translucentBlackView.layer.mask = gradientLayer;
}

- (void)spotlightView_2 {
    GradientTransparentView *gradientView = [[GradientTransparentView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:gradientView];
}

- (void)spotlightView_1 {
//    UIView *backgroundView = [UIView.alloc initWithFrame:self.view.bounds];
//    backgroundView.layer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6].CGColor;
//    [self.view addSubview:backgroundView];
    
    
    // 创建半透明黑色视图
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:backgroundView];

    // 创建一个贝塞尔路径，它包括了整个视图
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.bounds];

    // 创建一个贝塞尔路径，它是透明区域的路径
    // 假设我们要创建一个在中心，宽100，高100的透明区域
    CGRect transparentRect = CGRectMake((self.view.bounds.size.width - 100)/2, (self.view.bounds.size.height - 100)/2, 100, 100);
    UIBezierPath *transparentPath = [UIBezierPath bezierPathWithRect:transparentRect];

    // 将透明路径从整个视图的路径中减去
    [path appendPath:transparentPath];
    path.usesEvenOddFillRule = YES;

    // 创建一个形状图层作为半透明视图的遮罩
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;

    // 将遮罩层添加到半透明视图上
    backgroundView.layer.mask = maskLayer;
}

@end
