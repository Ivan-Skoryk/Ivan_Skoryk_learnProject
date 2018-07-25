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

- (void)didTapSaveButton:(Employee *) emp;

@end

@interface CreateEmployeeViewController : UIViewController

@property(nonatomic, weak) id <CreateEmployeeDelegate> delegate;

- (void)dissmissKeyboard;

- (void)createEmployee;

- (IBAction)saveButtonAction:(id)sender;

@end

