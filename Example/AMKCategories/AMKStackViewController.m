//
//  AMKStackViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2022/7/8.
//  Copyright © 2022 AndyM129. All rights reserved.
//

#import "AMKStackViewController.h"

@interface AMKStackViewController ()
@property (nonatomic, strong, readwrite, nullable) AMKStackView *stackView;
@end

@implementation AMKStackViewController

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIViewController amk_pushViewController:self.new animated:YES];
    });
}

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
    self.view.backgroundColor = self.view.backgroundColor?:[UIColor whiteColor];
    
    __weak __typeof__(self)weakSelf = self;
    
    // 示例1
    [self.stackView addArrangedSeparatorWithTitle:@"直接用 UIPasteboard 粘贴" color:nil size:12];
    [self.stackView addArrangedSubview:({
        UITextField *textField = [UITextField.alloc init];
        textField.tag = 1;
        textField.height = 40;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField;
    })];
    [self.stackView addArrangedButton:@"UIPasteboard - 粘贴" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
        UITextField *textField = [weakSelf.view viewWithTag:1];
        textField.text = [UIPasteboard.generalPasteboard string];
    }];
    
    // 示例2
    if (@available(iOS 16.0, *)) {
        [self.stackView addArrangedSeparatorWithTitle:nil color:UIColor.clearColor size:60];
        [self.stackView addArrangedSeparatorWithTitle:@"通过 UIPasteControl 粘贴" color:nil size:12];
        [self.stackView addArrangedSubview:({
            UITextField *textField = [UITextField.alloc init];
            textField.tag = 2;
            textField.height = 40;
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField;
        })];
        [self.stackView addArrangedSubview:({
            UIPasteControlConfiguration *configuration = [UIPasteControlConfiguration.alloc init];
            //configuration.baseBackgroundColor = UIColor.orangeColor;
            //configuration.baseForegroundColor = UIColor.redColor;
            //configuration.cornerStyle = UIButtonConfigurationCornerStyleCapsule;
            //configuration.displayMode = UIPasteControlDisplayModeIconAndLabel;
            UIPasteControl *pasteControl = [UIPasteControl.alloc initWithConfiguration:configuration];
            pasteControl.target = [weakSelf.view viewWithTag:2];
            pasteControl.height = 40;
            pasteControl;
        })];
    }
    
    // 示例3
    if (@available(iOS 14.0, *)) {
        [self.stackView addArrangedSeparatorWithTitle:nil color:UIColor.clearColor size:60];
        [self.stackView addArrangedSeparatorWithTitle:@"检测 UIPasteboard 内容" color:nil size:12];
        [self.stackView addArrangedButton:@"bdwenku://wenku/operation?type=2&source=xxx&url=xxx" controlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            UIPasteboard.generalPasteboard.string = sender.currentTitle;
        }];
        [self.stackView addArrangedButton:@"度口令：#bdwenku://wenku/operation?type=2&source=xxx&url=xxx#" controlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            UIPasteboard.generalPasteboard.string = sender.currentTitle;
        }];
        [self.stackView addArrangedButton:@"eyJyZWZlciI6IjEwMjgyMDBvX3drd2ViNzYxNDEiLCJkb2NfaWQiOiJjNjg5ZDQ2M2ZiYjA2OWRjNTAyMmFhZWE5OThmY2MyMmJkZDE0M2QxIiwicm91dGVyIjoiYmR3ZW5rdTovL3dlbmt1L29wZXJhdGlvbj90eXBlPTEwOCZmcm9tPXdrc3Qmd2tzdF9yZWZlcj0xMDI4MjAwbyZkb2NfaWQ9YzY4OWQ0NjNmYmIwNjlkYzUwMjJhYWVhOTk4ZmNjMjJiZGQxNDNkMSZjYXJyeT0lN0IlMjJmcm9tJTIyJTNBJTIybWluaWFwcCUyMiUyQyUyMmRvY0lkJTIyJTNBJTIyYzY4OWQ0NjNmYmIwNjlkYzUwMjJhYWVhOTk4ZmNjMjJiZGQxNDNkMSUyMiUyQyUyMndvcmQlMjIlM0ElMjIlRTUlODUlQTUlRTUlODUlOUElRTclOTQlQjMlRTglQUYlQjclMjIlN0QiLCJmcm9tIjoid2Vua3VhcHAifQ==" controlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            UIPasteboard.generalPasteboard.string = sender.currentTitle;
        }];
        [self.stackView addArrangedButton:@"bdwenku://?eyJyZWZlciI6IjEwMjgyMDBvX3drd2ViNzYxNDEiLCJkb2NfaWQiOiJjNjg5ZDQ2M2ZiYjA2OWRjNTAyMmFhZWE5OThmY2MyMmJkZDE0M2QxIiwicm91dGVyIjoiYmR3ZW5rdTovL3dlbmt1L29wZXJhdGlvbj90eXBlPTEwOCZmcm9tPXdrc3Qmd2tzdF9yZWZlcj0xMDI4MjAwbyZkb2NfaWQ9YzY4OWQ0NjNmYmIwNjlkYzUwMjJhYWVhOTk4ZmNjMjJiZGQxNDNkMSZjYXJyeT0lN0IlMjJmcm9tJTIyJTNBJTIybWluaWFwcCUyMiUyQyUyMmRvY0lkJTIyJTNBJTIyYzY4OWQ0NjNmYmIwNjlkYzUwMjJhYWVhOTk4ZmNjMjJiZGQxNDNkMSUyMiUyQyUyMndvcmQlMjIlM0ElMjIlRTUlODUlQTUlRTUlODUlOUElRTclOTQlQjMlRTglQUYlQjclMjIlN0QiLCJmcm9tIjoid2Vua3VhcHAifQ==" controlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            UIPasteboard.generalPasteboard.string = sender.currentTitle;
        }];
        [self.stackView addArrangedButton:@"检测" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
            NSSet *patterns = [NSSet setWithArray:@[UIPasteboardDetectionPatternProbableWebURL, UIPasteboardDetectionPatternNumber]];
            [UIPasteboard.generalPasteboard detectPatternsForPatterns:patterns completionHandler:^(NSSet<UIPasteboardDetectionPattern> *set, NSError *error) {
                NSLog(@"%@, %@", set, error);
                [weakSelf showAlertWithTitle:@"检测结果" content:error?:set];
            }];
        }];
        [self.stackView addArrangedButton:@"检测" controlEvents:UIControlEventTouchUpInside block:^(id sender) {
            NSSet *patterns = [NSSet setWithArray:@[UIPasteboardDetectionPatternProbableWebURL, UIPasteboardDetectionPatternNumber]];
            [UIPasteboard.generalPasteboard detectValuesForPatterns:patterns completionHandler:^(NSDictionary<UIPasteboardDetectionPattern,id> *dict, NSError *error) {
                NSLog(@"%@, %@", dict, error);
                [weakSelf showAlertWithTitle:@"检测结果" content:error?:dict];
            }];
        }];
    }
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

#pragma mark - Action Methods

- (void)showAlertWithTitle:(NSString *)title content:(id)content {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        NSString *message = [content description];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
        [UIViewController.amk_topViewController presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Protocol

#pragma mark - Helper Methods

@end
