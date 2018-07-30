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

@property (strong, nonatomic) HSDatePickerViewController *datePicker;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *salaryTextField;
@property (weak, nonatomic) IBOutlet UIButton *setDateButton;


@end

@implementation CreateEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDatePicker];
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    [self.view addGestureRecognizer:self.tap];
}

#pragma mark - Utility features

- (void)dissmissKeyboard {
    [self.view endEditing:true];
}

- (void)initDatePicker {
    self.datePicker = [[HSDatePickerViewController alloc] init];
    self.datePicker.delegate = self;
    [self.datePicker.dateFormatter setDateFormat:@"MMM dd"];
    [self.datePicker.monthAndYearLabelDateFormater setDateFormat:@"MMMM YYYY"];
}

- (void)createEmployee {
    if (![self.firstNameTextField.text  isEqual: @""] || ![self.lastNameTextField.text  isEqual: @""] || ![self.salaryTextField.text  isEqual: @""] || !self.date) {
        EmployeeMO *emp = [EmployeeMO addNewEmployeeWithFirstName:self.firstNameTextField.text lastName:self.lastNameTextField.text salary:[self.salaryTextField.text intValue] dateOfBirth:self.date];
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

- (IBAction)setDateAction:(id)sender {
    [self presentViewController:self.datePicker animated:YES completion:nil];
}

#pragma mark - HSDatePickerViewControllerDelegate

- (void)hsDatePickerPickedDate:(NSDate *)date {
    self.date = date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.YYYY"];
    [self.setDateButton setTitle:[NSString stringWithFormat:@"%@", [df stringFromDate:self.date]] forState:UIControlStateNormal];
}

@end
