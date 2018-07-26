//
//  Organization.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Employee.h"

@interface Organization : NSManagedObject
    
@property (strong, nonatomic) NSString *name;

- (id)initWithManagedObject:(NSManagedObject *)obj;

- (void)loadEmployeesFromArray:(NSArray *)empArr;

- (void)addEmployeeWithName:(NSString *)empName;

- (void)addEmployee:(Employee *)emp;

- (int)calculateAverageSalary;

- (Employee *)employeeWithLowestSalary;

- (NSArray<Employee *> *)employeesWithSalary:(int)sal tolerance:(int)tol;

- (void)removeEmployee:(Employee *)employee;

- (NSArray<Employee *> *)getEmployeeArray;

- (Employee *)getEmployeeAtIndex:(NSInteger)index;

@end
