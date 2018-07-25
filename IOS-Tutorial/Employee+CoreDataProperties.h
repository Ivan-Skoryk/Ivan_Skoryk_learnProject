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

@property (nonatomic) int16_t idEmployee;
@property (nonatomic) int16_t idOrganization;

@end

NS_ASSUME_NONNULL_END
