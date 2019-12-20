//
//  AMKKeyPathCodingViewController.m
//  AMKCategories_Example
//
//  Created by 孟昕欣 on 2019/12/20.
//  Copyright © 2019 AndyM129. All rights reserved.
//

#import "AMKKeyPathCodingViewController.h"
#import <AMKCategories/NSObject+AMKKeyPathCoding.h>

@interface Employee : NSObject
@property(nonatomic, strong, nullable, readwrite) NSString *firstName;
@end
@implementation Employee @end

@interface Department : NSObject
@property(nonatomic, strong, nullable, readwrite) NSMutableArray<Employee *> *employees;
@end
@implementation Department @end

@interface AMKKeyPathCodingViewController () @end
@implementation AMKKeyPathCodingViewController

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIViewController amk_gotoViewController:[self new] transitionStyle:AMKViewControllerTransitionStylePush animated:YES];
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
    
    [self test_1];
    [self test_2];
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

#pragma mark - Data & Networking

#pragma mark - Layout Subviews

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)test_1 {
    NSString *str = @"asdfgh";
    
    NSString *UTF8StringPath = @amk_keypath(str.lowercaseString.UTF8String);
    // => @"lowercaseString.UTF8String"
    
    NSString *versionPath = @amk_keypath(NSObject, version);
    // => @"version"
    
    NSString *lowercaseStringPath = @amk_keypath(NSString.new, lowercaseString);
    // => @"lowercaseString"
}

- (void)test_2 {
    Department *department = [Department.alloc init];
    department.employees = @[].mutableCopy;
    [department.employees addObject:({
        Employee *employee = [Employee.alloc init];
        employee.firstName = @"Meng";
        employee;
    })];
    
    NSString *employessFirstNamePath = @amk_collectionKeypath(department.employees, Employee.new, firstName);
    // => @"employees.firstName"
    
    NSString *employessFirstNamePath2 = @amk_collectionKeypath(Department.new, employees, Employee.new, firstName);
    // => @"employees.firstName"
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark - Override

#pragma mark - Helper Methods

@end
