//
//  CreateEmployeeViewController.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/24/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@protocol CreateEmployeeDelegate <NSObject>

- (void) didTapSaveButton:(Employee*) emp;

@end

@interface CreateEmployeeViewController : UIViewController {
    id <CreateEmployeeDelegate> _delegate;
}

@property (nonatomic, weak) id delegate;

@property (strong, nonatomic) Employee *employee;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *salaryTextField;

- (void) dissmissKeyboard;

- (void) createEmployee;

- (IBAction)saveButtonAction:(id)sender;

@end

