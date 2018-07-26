//
//  Employee.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

@interface Employee ()

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

@end

@implementation Employee

@synthesize firstName;
@synthesize lastName;
@synthesize salary;

- (NSString *)fullName {
    return [[self.firstName stringByAppendingString:@" "] stringByAppendingString: self.lastName];
}

#pragma mark - Initialization

- (id)initWithManagedObject:(NSManagedObject *)obj {
    
    self.firstName = [[obj valueForKey:@"firstName"] copy];
    self.lastName = [[obj valueForKey:@"lastName"] copy];
    self.salary = [[obj valueForKey:@"salary"] intValue];
    
    return self;
}

@end
