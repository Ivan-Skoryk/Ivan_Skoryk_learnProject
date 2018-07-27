//
//  EmployeeMO+CoreDataClass.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/26/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "EmployeeMO.h"
#import "AppDelegate.h"

@implementation EmployeeMO

+ (EmployeeMO *)addNewEmployeeWithFirstName:(NSString *)fName lastName:(NSString *)lName salary:(int)sal {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    
    EmployeeMO *emp = [NSEntityDescription insertNewObjectForEntityForName:@"EmployeeMO" inManagedObjectContext:context];
    [emp setValue:fName forKey:@"firstName"];
    [emp setValue:lName forKey:@"lastName"];
    [emp setValue:@(sal) forKey:@"salary"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    return emp;
}

+ (EmployeeMO *)employeeToMO:(Employee *)emp {
    EmployeeMO *mo = [[EmployeeMO alloc] init];
    mo.firstName = [emp.fullName componentsSeparatedByString:@" "][0];
    mo.lastName = [emp.fullName componentsSeparatedByString:@" "][1];
    mo.salary = emp.salary;
    
    return mo;
}

- (Employee *)moToEmployee {
    return [[Employee alloc] initWithFirstName:self.firstName lastName:self.lastName salary:self.salary];
}

@end