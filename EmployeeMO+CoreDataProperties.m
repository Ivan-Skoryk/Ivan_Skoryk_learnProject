//
//  EmployeeMO+CoreDataProperties.m
//  
//
//  Created by Ivan Skoryk on 7/27/18.
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
@dynamic dateOfBirth;
@dynamic organization;

@end
