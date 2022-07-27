//
//  AMKMBProgressHUDViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/6/22.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKMBProgressHUDViewController.h"

@interface AMKMBProgressHUDViewController ()
@property (nonatomic, strong, readwrite, nullable) AMKStackView *stackView;
@end

@implementation AMKMBProgressHUDViewController

//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIViewController amk_pushViewController:self.new animated:YES];
//    });
//}

#pragma mark - Dealloc

- (void)dealloc {
    
}

#pragma mark - Init Methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"MBProgressHUD 扩展";
    }
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
    
    //MBProgressHUD.appearance.offset = CGPointMake(0, -200);
    
    __weak __typeof__(self)weakSelf = self;
    [self.stackView addArrangedButton:@"仅内容" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [MBProgressHUD amk_showTextHUDWithMessage:@"MBProgressHUD 示例" inView:weakSelf.view responder:nil duration:3 animated:YES];
    }];
    [self.stackView addArrangedButton:@"标题+内容" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [MBProgressHUD amk_showTextHUDWithTitle:@"MBProgressHUD 示例" message:@"标题+内容" inView:weakSelf.view responder:nil duration:3 animated:YES];
    }];
    [self.stackView addArrangedButton:@"超长标题+超长内容+阻隔交互" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [MBProgressHUD amk_showTextHUDWithTitle:@"MBProgressHUD 示例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例" message:@"超长标题+超长内容+阻隔交互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互" inView:weakSelf.view responder:nil duration:3 animated:YES userInteractionEnabled:NO];
    }];

    [self.stackView addArrangedSeparatorWithTitle:nil color:nil size:0];
    [self.stackView addArrangedButton:@"Loading+标题+内容" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [MBProgressHUD amk_showLoadingHUDWithTitle:@"MBProgressHUD 示例" message:@"Loading+标题+内容" inView:weakSelf.view responder:nil duration:3 animated:YES userInteractionEnabled:NO];
    }];
    [self.stackView addArrangedButton:@"Loading+标题+内容+阻隔交互" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [MBProgressHUD amk_showLoadingHUDWithTitle:@"MBProgressHUD 示例" message:@"Loading+标题+内容+阻隔交互" inView:weakSelf.view responder:nil duration:3 animated:YES userInteractionEnabled:YES];
    }];
    [self.stackView addArrangedButton:@"Loading+超长标题+超长内容+阻隔交互" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [MBProgressHUD amk_showLoadingHUDWithTitle:@"MBProgressHUD 示例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例" message:@"Loading+标题+内容+阻隔交互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互" inView:weakSelf.view responder:nil duration:3 animated:YES userInteractionEnabled:YES];
    }];
    
    [self.stackView addArrangedSeparatorWithTitle:nil color:nil size:0];
    [self.stackView addArrangedButton:@"图片视图+标题+内容" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        UIImage *image = [UIImage imageWithColor:UIColor.lightGrayColor size:CGSizeMake(100, 100)];
        UIImageView *imageView = [UIImageView.alloc initWithImage:image];
        [MBProgressHUD amk_showHUDWithCustomView:imageView title:@"MBProgressHUD 示例" message:@"图片视图+标题+内容" inView:weakSelf.view responder:nil duration:3 animated:YES];
    }];
    [self.stackView addArrangedButton:@"自定义视图+标题+内容+阻隔交互" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        UIView *customView = [AMKMBProgressHUDCustomView.alloc initWithFrame:CGRectMake(0, 0, 100, 100)];
        customView.backgroundColor = UIColor.lightGrayColor;
        [MBProgressHUD amk_showHUDWithCustomView:customView title:@"MBProgressHUD 示例" message:@"自定义视图+标题+内容+阻隔交互" inView:weakSelf.view responder:nil duration:3 hideBeforeHUD:YES animated:YES userInteractionEnabled:YES];
    }];
    
    [self.stackView addArrangedSeparatorWithTitle:nil color:nil size:0];
    [self.stackView addArrangedButton:@"自定义视图+极限标题+极限内容" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        UIView *customView = [AMKMBProgressHUDCustomView.alloc initWithFrame:CGRectMake(0, 0, 100, 100)];
        customView.backgroundColor = UIColor.lightGrayColor;
        [MBProgressHUD amk_showHUDWithCustomView:customView title:@"MBProgressHUD 示例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例" message:@"自定义视图+标题+内容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容容" inView:weakSelf.view responder:nil duration:3 hideBeforeHUD:YES animated:YES userInteractionEnabled:NO];
    }];
    [self.stackView addArrangedButton:@"修改默认样式" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        MBProgressHUD.appearance.offset = CGPointMake(0.f, UIScreen.mainScreen.bounds.size.height/3);
        MBProgressHUD.appearance.margin = 0;
        MBProgressHUD.appearance.square = YES;
        MBProgressHUD.appearance.contentColor = [UIColor.redColor colorWithAlphaComponent:0.9];
        MBProgressHUD.appearance.amk_contentBackgroundColor = [UIColor.yellowColor colorWithAlphaComponent:0.9];
        MBProgressHUD.appearance.amk_labelFont = [UIFont boldSystemFontOfSize:18];
        MBProgressHUD.appearance.amk_detailsLabelFont = [UIFont boldSystemFontOfSize:14];
        MBProgressHUD.appearance.amk_labelLineSpacing = 20;
        MBProgressHUD.appearance.amk_detailsLabelLineSpacing = 10;
        [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[MBProgressHUD.class]].color = MBProgressHUD.appearance.contentColor;
        [MBProgressHUD amk_showLoadingHUDWithTitle:@"MBProgressHUD 示例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例" message:@"Loading+标题+内容+阻隔交互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互" inView:weakSelf.view responder:nil duration:3 animated:YES userInteractionEnabled:NO];
    }];
    [self.stackView addArrangedButton:@"恢复默认样式" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        MBProgressHUD.appearance.offset = CGPointZero;
        MBProgressHUD.appearance.margin = 20;
        MBProgressHUD.appearance.square = NO;
        MBProgressHUD.appearance.contentColor = nil;
        MBProgressHUD.appearance.amk_contentBackgroundColor = nil;
        MBProgressHUD.appearance.amk_labelFont = nil;
        MBProgressHUD.appearance.amk_detailsLabelFont = nil;
        MBProgressHUD.appearance.amk_labelLineSpacing = CGFLOAT_MIN;
        MBProgressHUD.appearance.amk_detailsLabelLineSpacing = CGFLOAT_MIN;
        [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[MBProgressHUD.class]].color = nil;
        [MBProgressHUD amk_showLoadingHUDWithTitle:@"MBProgressHUD 示例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例例" message:@"Loading+标题+内容+阻隔交互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互互" inView:weakSelf.view responder:nil duration:3 animated:YES userInteractionEnabled:NO];
    }];
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

- (AMKStackView *)stackView {
    if (!_stackView) {
        _stackView = [AMKStackView.alloc initWithAxis:UILayoutConstraintAxisVertical spacing:20];
        [self.view addSubview:_stackView];
        [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
    }
    return _stackView;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Overrides

#pragma mark - Helper Methods

@end
