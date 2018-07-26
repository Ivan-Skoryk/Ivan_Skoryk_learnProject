//
//  OrganizationMO+CoreDataClass.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/26/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Organization.h"

@class EmployeeMO;

NS_ASSUME_NONNULL_BEGIN

@interface OrganizationMO : NSManagedObject

- (OrganizationMO *)addNewOrganizationWithName:(NSString *)name;
//+ (void)updateOrganizationByName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#import "OrganizationMO+CoreDataProperties.h"
