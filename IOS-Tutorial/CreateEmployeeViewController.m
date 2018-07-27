//
//  CreateEmployeeViewController.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/24/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import "CreateEmployeeViewController.h"

@interface CreateEmployeeViewController ()

#pragma mark - Variables

@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *salaryTextField;

@end

@implementation CreateEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    
    [self.view addGestureRecognizer:self.tap];
}

#pragma mark - Utility features

- (void)dissmissKeyboard {
    [self.view endEditing:true];
}

- (void)createEmployee {
    if (![self.firstNameTextField.text  isEqual: @""] || ![self.lastNameTextField.text  isEqual: @""] || ![self.salaryTextField.text  isEqual: @""]) {
        EmployeeMO *emp = [EmployeeMO addNewEmployeeWithFirstName:self.firstNameTextField.text lastName:self.lastNameTextField.text salary:[self.salaryTextField.text intValue]];
        [self.delegate didTapSaveButton:emp];
        [self.navigationController popViewControllerAnimated:true];
    } else {
        [self alert];
    }
    
}

- (void)alert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                   message:@"You must fill in all fields."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Handlers

- (IBAction)saveButtonAction:(id)sender {
    [self createEmployee];
}

@end
