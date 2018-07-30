//
//  CreateEmployeeViewController.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/24/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"
#import "EmployeeMO.h"
#import "HSDatePickerViewController.h"

@protocol CreateEmployeeDelegate <NSObject>

- (void)didTapSaveButton:(EmployeeMO *) emp;

@end

@interface CreateEmployeeViewController : UIViewController<HSDatePickerViewControllerDelegate>

@property (nonatomic, weak) id <CreateEmployeeDelegate> delegate;

- (void)dissmissKeyboard;

- (void)initDatePicker;

- (void)createEmployee;

- (IBAction)saveButtonAction:(id)sender;

@end

