//
//  OrganizationMO+CoreDataProperties.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/26/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "OrganizationMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrganizationMO (CoreDataProperties)

+ (NSFetchRequest<OrganizationMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<EmployeeMO *> *employees;

@end

@interface OrganizationMO (CoreDataGeneratedAccessors)

- (void)addEmployeesObject:(EmployeeMO *)value;
- (void)removeEmployeesObject:(EmployeeMO *)value;
- (void)addEmployees:(NSSet<EmployeeMO *> *)values;
- (void)removeEmployees:(NSSet<EmployeeMO *> *)values;

@end

NS_ASSUME_NONNULL_END
