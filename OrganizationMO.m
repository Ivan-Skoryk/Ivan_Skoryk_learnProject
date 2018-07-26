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

@implementation OrganizationMO

- (OrganizationMO *)addNewOrganizationWithName:(NSString *)name {
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

//+ (void)updateOrganizationWithEmployee:(Employee *)emp (NSString *)name {
//    
//}

@end
