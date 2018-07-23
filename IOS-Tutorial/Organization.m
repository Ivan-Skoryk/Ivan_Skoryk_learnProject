//
//  Organization.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Organization.h"

@implementation Organization

- (id)initWithName:(NSString*)orgName {
    name = orgName;
    employees = [[NSArray alloc] init];
    return self;
}

- (void)addEmployeeWithName:(NSString*) empName {
    Employee *emp = [[Employee alloc] initWithFirstName:[empName componentsSeparatedByString:@" "][0] \
                                               lastName:[empName componentsSeparatedByString:@" "][1] \
                                                 salary:((arc4random_uniform(491) + 10)*10)];
    [self addEmployee:emp];
}

- (void)addEmployee:(Employee*)emp {
    NSMutableArray *tmp = [employees mutableCopy];
    [tmp addObject:emp];
    employees = tmp;
}

- (int)calculateAverageSalary {
    int res = 0;
    for(int i = 0; i < [employees count]; i++) {
        res += employees[i]->salary;
    }
    res /= [employees count];
    return res;
}

- (Employee *)employeeWithLowestSalary {
    if ([employees count] != 0) {
        Employee *emp = employees[0];
        for(int i = 1; i < [employees count]; i++) {
            if(emp->salary > employees[i]->salary) {
                emp = employees[i];
            }
        }
        return emp;
    }
    else return nil;
}

- (NSArray<Employee*>*)employeesWithSalary:(int) sal tolerance:(int) tol {
    if ([employees count] != 0) {
        NSMutableArray<Employee*> *tmp = [[NSMutableArray alloc] init];;
        
        for(int i = 0; i < [employees count]; i++) {
            if(employees[i]->salary >= (sal - tol) && employees[i]->salary <= (sal + tol)) {
                [tmp addObject:employees[i]];
            }
        }
        NSArray<Employee*> *empArray = [tmp copy];
        return empArray;
    }
    else return nil;
}

- (void)removeEmployee:(Employee *)employee {
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:employees];
    [tmp removeObject:employee];
    employees = [NSArray arrayWithArray:tmp];
}

@end
