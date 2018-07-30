//
//  Organization.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

@interface Organization : NSObject
    
@property (strong, nonatomic) NSString *name;

- (id)initWithName:(NSString *)orgName;

- (void)reloadEmployeesWithArray:(NSArray *)empArr;

- (void)addEmployeeWithName:(NSString *)empName;

- (void)addEmployee:(Employee *)emp;

- (void)randomizeOrder;

- (int)calculateAverageSalary;

- (int)calculateSalarySum;

- (Employee *)employeeWithLowestSalary;

- (NSArray<Employee *> *)employeesWithSalary:(int)sal tolerance:(int)tol;

- (void)removeEmployee:(Employee *)employee;

- (NSArray<Employee *> *)getEmployeeArray;

- (Employee *)getEmployeeAtIndex:(NSInteger)index;

@end
