//
//  EmployeeMO+CoreDataClass.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/26/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Employee.h"

@class OrganizationMO;

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeMO : NSManagedObject

+ (EmployeeMO *)addNewEmployeeWithFirstName:(NSString *)fName lastName:(NSString *)lName salary:(int)sal;
+ (EmployeeMO *)employeeToMO:(Employee *)emp;
+ (Employee *)moToEmployee:(NSManagedObject *)mo;

@end

NS_ASSUME_NONNULL_END

#import "EmployeeMO+CoreDataProperties.h"
