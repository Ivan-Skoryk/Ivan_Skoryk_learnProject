//
//  OrganizationMO+CoreDataClass.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/26/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//
//

#import "OrganizationMO.h"
#import "AppDelegate.h"
#import "EmployeeMO.h"

@implementation OrganizationMO

+ (OrganizationMO *)addNewOrganizationWithName:(NSString *)name {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    
    OrganizationMO *org = [NSEntityDescription insertNewObjectForEntityForName:@"OrganizationMO" inManagedObjectContext:context];
    [org setValue:name forKey:@"name"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    return org;
}

+ (Organization *)moToOrganization:(OrganizationMO *)mo {
    Organization *org = [[Organization alloc] initWithName:[mo valueForKey:@"name"]];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mainContext = delegate.persistentContainer.viewContext;
    NSManagedObjectContext *threadContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [threadContext setParentContext:mainContext];
    
    NSFetchRequest *request = [EmployeeMO fetchRequest];

    [request setPredicate:[NSPredicate predicateWithFormat:@"organization.name == %@", org.name]];
    NSArray<NSManagedObject *> *emp = [threadContext executeFetchRequest:request error:nil];
    for(int i = 0; i < [emp count]; i++) {
        [org addEmployee:[EmployeeMO moToEmployee:emp[i]]];
    }
    return org;
}

@end
