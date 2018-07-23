//
//  Employee.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject {
    
    @private
    NSString *firstName;
    NSString *lastName;
    
    @public
    int salary;
}

@property(nonatomic, readonly)NSString *fullName;

- (id)initWithFirstName:(NSString*)fName lastName:(NSString*)lName salary:(int)sal;

@end

@implementation Employee

- (NSString*)fullName {
    return [[firstName stringByAppendingString:@" "] stringByAppendingString: lastName];
}
- (id)initWithFirstName:(NSString*)fName lastName:(NSString*)lName salary:(int)sal {
    firstName = fName;
    lastName = lName;
    salary = sal;
    return self;
}

@end

@interface Organization : NSObject {
    
    @public
    NSString *name;
    
    @private
    NSArray<Employee *> *employees;
}

- (id)initWithName:(NSString*)orgName;

- (void)addEmployeeWithName:(NSString*) empName;

- (void)addEmployee:(Employee*)emp;

- (int)calculateAverageSalary;

- (Employee *)employeeWithLowestSalary;

- (NSArray<Employee*>*)employeesWithSalary:(int) sal tolerance:(int) tol;

@end

@implementation Organization

- (id)initWithName:(NSString*)orgName {
    name = orgName;
    employees = [NSArray array];
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

@end
































