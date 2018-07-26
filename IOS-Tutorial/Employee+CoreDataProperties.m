//
//  Employee+CoreDataProperties.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/25/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "Employee+CoreDataProperties.h"
#import "AppDelegate.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
}

//Adding new employee to the database
+ (NSManagedObject *)addEmployeeWithFirstName:(NSString *)fName lastName:(NSString *)lName salary:(int)sal {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    
    NSManagedObject *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    NSInteger empAI = [[NSUserDefaults standardUserDefaults] integerForKey:@"employeeAutoIncrement"];
    [newEmployee setValue:@(empAI) forKey:@"idEmployee"];
    [newEmployee setValue:@(1) forKey:@"idOrganization"];
    [newEmployee setValue:fName forKey:@"firstName"];
    [newEmployee setValue:lName forKey:@"lastName"];
    [newEmployee setValue:@(sal) forKey:@"salary"];
    empAI += 1;
    [[NSUserDefaults standardUserDefaults] setInteger:empAI forKey:@"employeeAutoIncrement"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    return newEmployee;
}

@dynamic firstName;
@dynamic idEmployee;
@dynamic idOrganization;
@dynamic lastName;
@dynamic salary;

@end
