//
//  AppDelegate.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import "AppDelegate.h"
#import "Organization.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
    NSLog(@"Init employee\n");
    Employee *emp = [[Employee alloc] initWithFirstName:@"Vasiliy" lastName:@"Poopkin" salary:2500];
    NSLog(@"Employee name: %@\tSalary: %d", emp.fullName, emp->salary);
    
    NSLog(@"Init organization");
    Organization *org = [[Organization alloc] initWithName:@"Balalaika Ltd."];
    NSLog(@"Organization: %@", org->name);
    
    NSLog(@"Adding some employees to organization");
    for (int i = 0; i < 7; i++) {
        NSString *str = [NSString stringWithFormat:@"Name%d Surname%d", i, i];
        [org addEmployeeWithName:str];
        NSLog(@"Employee added with name: %@", str);
    }
    
    [org addEmployee:emp];
    NSLog(@"Employee added by instance: Name: %@\tSalary: %d", emp.fullName, emp->salary);
    
    int avgSalary = [org calculateAverageSalary];
    NSLog(@"Average salary in the company(%@) is %d", org->name, avgSalary);
    
    Employee *tmpEmp = [org employeeWithLowestSalary];
    NSLog(@"Employee with the lowest salary is: Name: %@\tSalary: %d", tmpEmp.fullName, tmpEmp->salary);
    
    int tolerance  = 500;
    
    NSLog(@"Employees with salary near %d (tolerance: %d):", avgSalary, tolerance);
    NSArray<Employee*> *tmpEmpArr = [org employeesWithSalary:avgSalary tolerance:tolerance];
    for(int i = 0; i < [tmpEmpArr count]; i++) {
        NSLog(@"Name: %@", tmpEmpArr[i].fullName);
    }
    
    NSLog(@"Removing employee: Name: %@", emp.fullName);
    [org removeEmployee:emp];
    NSLog(@"Removed.");
    */
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
