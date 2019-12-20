//
//  AMKEmojiStringViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2019/12/20.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import "AMKEmojiStringViewController.h"

@interface AMKEmojiStringViewController ()
@property(nonatomic, strong, nullable, readonly) NSString *emojiString;
@property(nonatomic, strong, nullable, readwrite) UITextView *textView;
@property(nonatomic, strong, nullable, readwrite) UITextField *textField;
@property(nonatomic, strong, nullable, readwrite) UIStepper *stepper;
@end

@implementation AMKEmojiStringViewController

//+ (void)load {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIViewController amk_gotoViewController:[self new] transitionStyle:AMKViewControllerTransitionStylePush animated:YES];
//    });
//}

#pragma mark - Dealloc

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:_textField];
    
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
    [self.view addGestureRecognizer:[UITapGestureRecognizer.alloc initWithTarget:self.view action:@selector(endEditing:)]];
    self.textView.text = self.emojiString;
    self.stepper.value = self.stepper.maximumValue;
    [self didChangeStepperValue:nil];
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

- (NSString *)emojiString {
    static NSString *emojiString = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emojiString = [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"AMKEmojiStringViewController.txt" ofType:@""] encoding:NSUTF8StringEncoding error:nil];
    });
    return emojiString;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView.alloc init];
        _textView.editable = NO;
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.view);
            make.height.mas_equalTo(self.view).multipliedBy(0.5);
        }];
    }
    return _textView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField.alloc init];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderWidth = 0.5;
        _textField.textAlignment = NSTextAlignmentCenter;
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didHandleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:_textField];
        [self.view addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.top.mas_equalTo(self.textView.mas_bottom).offset(10);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(self.view).offset(-110);
        }];
    }
    return _textField;
}

- (UIStepper *)stepper {
    if (!_stepper) {
        _stepper = [UIStepper.alloc init];
        _stepper.minimumValue = 0;
        _stepper.maximumValue = self.emojiString.length;
        [_stepper addTarget:self action:@selector(didChangeStepperValue:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_stepper];
        [_stepper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textField.mas_right).offset(5);
            make.right.mas_equalTo(self.view);
            make.height.mas_equalTo(34);
            make.centerY.mas_equalTo(self.textField);
        }];
    }
    return _stepper;
}

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)didChangeStepperValue:(id)sender {
    NSInteger length = self.stepper.value;
    self.textField.text = [NSString stringWithFormat:@"%ld", length];
    self.textView.text = [self.emojiString substringToIndex:length];
    [self.textView scrollRangeToVisible:NSMakeRange(length, 0)];
}

#pragma mark - Notifications

- (void)didHandleTextFieldTextDidChangeNotification:(id)sender {
    self.stepper.value = self.textField.text.integerValue;
    [self didChangeStepperValue:sender];
}

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods



@end
