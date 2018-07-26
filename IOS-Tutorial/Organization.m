//
//  Organization.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Organization.h"

@interface Organization ()

@property (strong, nonatomic) NSArray<Employee *> *employees;

@end

@implementation Organization

@synthesize employees;
@synthesize name;

#pragma mark - Initialization

- (id)initWithManagedObject:(NSManagedObject *)obj {
    self.name = [[obj valueForKey:@"name"] copy];
    self.employees = [[NSArray alloc] init];
    return self;
}

#pragma mark - Adding features

- (void)loadEmployeesFromArray:(NSArray<NSManagedObject *> *)empArr {
    NSMutableArray *tmp = [self.employees mutableCopy];;
    [tmp removeAllObjects];
    for(int i = 0; i < [empArr count]; i++) {
        Employee *emp = [[[Employee alloc] init] initWithManagedObject:empArr[i]];
        [tmp addObject:emp];
    }
    self.employees = [tmp copy];
}

- (void)addEmployeeWithName:(NSString *)empName {
    [Employee addEmployeeWithFirstName:[empName componentsSeparatedByString:@" "][0]
                              lastName:[empName componentsSeparatedByString:@" "][1]
                                salary:((arc4random_uniform(491) + 10)*10)];
}

- (void)addEmployee:(Employee *)emp {
    NSMutableArray *tmp = [self.employees mutableCopy];
    [tmp addObject:emp];
    self.employees = [tmp copy];
}

#pragma mark - Ыelecting features

- (int)calculateAverageSalary {
    int res = 0;
    for(int i = 0; i < [self.employees count]; i++) {
        res += self.employees[i].salary;
    }
    res /= [self.employees count];
    return res;
}

- (Employee *)employeeWithLowestSalary {
    Employee *emp = self.employees[0];
    for(int i = 1; i < [self.employees count]; i++) {
        if(emp.salary > self.employees[i].salary) {
            emp = self.employees[i];
        }
    }
    return emp;
}

- (NSArray<Employee *> *)employeesWithSalary:(int)sal tolerance:(int)tol {
        NSMutableArray<Employee*> *tmp = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < [self.employees count]; i++) {
            if(self.employees[i].salary >= (sal - tol) && self.employees[i].salary <= (sal + tol)) {
                [tmp addObject:self.employees[i]];
            }
        }
        NSArray<Employee *> *empArray = [tmp copy];
        return empArray;
}

#pragma mark - Remove feature

- (void)removeEmployee:(Employee *)employee {
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.employees];
    [tmp removeObject:employee];
    self.employees = [NSArray arrayWithArray:tmp];
}

#pragma mark - Getting features

- (NSArray<Employee *> *)getEmployeeArray {
    return self.employees;
}

- (Employee*)getEmployeeAtIndex:(NSInteger)index {
        return self.employees[index];
}

@end
