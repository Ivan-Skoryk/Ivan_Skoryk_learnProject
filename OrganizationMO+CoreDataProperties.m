//
//  OrganizationMO+CoreDataProperties.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/26/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "OrganizationMO+CoreDataProperties.h"

@implementation OrganizationMO (CoreDataProperties)

+ (NSFetchRequest<OrganizationMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"OrganizationMO"];
}

@dynamic name;
@dynamic employees;

@end
