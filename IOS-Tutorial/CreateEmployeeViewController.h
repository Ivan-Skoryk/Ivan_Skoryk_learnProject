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
#import "OrganizationMO.h"

@protocol CreateEmployeeDelegate <NSObject>

- (void)didTapSaveButton:(EmployeeMO *) emp;

@end

@interface CreateEmployeeViewController : UIViewController

@property (nonatomic, weak) id <CreateEmployeeDelegate> delegate;

- (void)dissmissKeyboard;

- (void)createEmployee;

- (IBAction)saveButtonAction:(id)sender;

@end

