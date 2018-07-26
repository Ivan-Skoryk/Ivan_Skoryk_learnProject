//
//  Employee+CoreDataProperties.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/25/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "Employee.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest;

+ (NSManagedObject *)addEmployeeWithFirstName:(NSString *)fName lastName:(NSString *)lName salary:(int)sal;

@property (nonatomic) int16_t idEmployee;
@property (nonatomic) int16_t idOrganization;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nonatomic) int32_t salary;

@end

NS_ASSUME_NONNULL_END
