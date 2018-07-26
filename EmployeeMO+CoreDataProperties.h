//
//  EmployeeMO+CoreDataProperties.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/26/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "EmployeeMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeMO (CoreDataProperties)

+ (NSFetchRequest<EmployeeMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nonatomic) int32_t salary;
@property (nullable, nonatomic, retain) OrganizationMO *organization;

@end

NS_ASSUME_NONNULL_END
