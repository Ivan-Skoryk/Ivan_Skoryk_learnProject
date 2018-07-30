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

+ (NSManagedObject *)addNewEmployeeWithFirstName:(NSString *)firstName lastName:(NSString *)lastName salary:(int)sal dateOfBirth:(NSDate*)dob {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    
    NSManagedObject *emp = [NSEntityDescription insertNewObjectForEntityForName:@"EmployeeMO" inManagedObjectContext:context];
    [emp setValue:firstName forKey:@"firstName"];
    [emp setValue:lastName forKey:@"lastName"];
    [emp setValue:@(sal) forKey:@"salary"];
    [emp setValue:dob forKey:@"dateOfBirth"];
    
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

+ (Employee *)moToEmployee:(NSManagedObject *)mo {
    return [[Employee alloc] initWithFirstName:[mo valueForKey:@"firstName"] lastName:[mo valueForKey:@"lastName"] salary:[[mo valueForKey:@"salary"] intValue] dateOfBirth:[mo valueForKey:@"dateOfBirth"]];
}

@end
