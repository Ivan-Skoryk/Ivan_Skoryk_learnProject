//
//  CreateEmployeeViewController.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/24/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import "CreateEmployeeViewController.h"

@interface CreateEmployeeViewController ()

@end

@implementation CreateEmployeeViewController

#pragma mark - Variables

@synthesize delegate;
@synthesize employee;
@synthesize tap;
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize salaryTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

#pragma mark - Utility features

- (void) dissmissKeyboard {
    [self.view endEditing:true];
}

- (void) createEmployee {
    if (![firstNameTextField.text  isEqual: @""] || ![lastNameTextField.text  isEqual: @""] || ![salaryTextField.text  isEqual: @""]) {
                employee = [[Employee alloc] initWithFirstName:firstNameTextField.text
                                                           lastName:lastNameTextField.text
                                                             salary:[salaryTextField.text intValue]];
    } else {
        [self alert];
    }
    
}

- (void) alert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                   message:@"You must fill in all fields."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Save Button

- (IBAction)saveButtonAction:(id)sender {
    [self createEmployee];
    [delegate didTapSaveButton:employee];
    [self.navigationController popViewControllerAnimated:true];
}

@end
