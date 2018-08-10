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

- (NSString *)fullName {
    return [[self.firstName stringByAppendingString:@" "] stringByAppendingString: self.lastName];
}

- (id)initWithFirstName:(NSString *)fName lastName:(NSString *)lName salary:(int)sal dateOfBirth:(NSDate*)dob {
    self.firstName = fName;
    self.lastName = lName;
    self.salary = sal;
    self.dateOfBirth = dob;
    
    return self;
}

@end
