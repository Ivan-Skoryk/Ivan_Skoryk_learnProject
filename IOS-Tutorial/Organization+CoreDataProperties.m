//
//  Organization+CoreDataProperties.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/26/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "Organization+CoreDataProperties.h"
#import "AppDelegate.h"

@implementation Organization (CoreDataProperties)

+ (NSFetchRequest<Organization *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Organization"];
}

+ (NSManagedObject *)addOrganizationWithName:(NSString *)name {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    
    NSManagedObject * newOrg = [NSEntityDescription insertNewObjectForEntityForName:@"Organization" inManagedObjectContext:context];
    NSInteger orgAI = [[NSUserDefaults standardUserDefaults] integerForKey:@"organizationAutoIncrement"];
    [newOrg setValue:@(orgAI) forKey:@"idOrganization"];
    [newOrg setValue:name forKey:@"name"];
    orgAI += 1;
    [[NSUserDefaults standardUserDefaults] setInteger:orgAI forKey:@"organizationAutoIncrement"];
    
    [[NSUserDefaults standardUserDefaults] setValue:@(1) forKey:@"employeeAutoIncrement"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    return newOrg;
}

@dynamic idOrganization;
@dynamic name;

@end
