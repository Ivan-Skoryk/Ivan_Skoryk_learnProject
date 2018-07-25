//
//  Organization+CoreDataProperties.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/25/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "Organization+CoreDataProperties.h"

@implementation Organization (CoreDataProperties)

+ (NSFetchRequest<Organization *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Organization"];
}

@dynamic idOrganization;

@end
