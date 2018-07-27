//
//  EmployeeMO+CoreDataProperties.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/26/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "EmployeeMO+CoreDataProperties.h"

@implementation EmployeeMO (CoreDataProperties)

+ (NSFetchRequest<EmployeeMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"EmployeeMO"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic salary;
@dynamic organization;

@end
