//
//  Employee.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

@implementation Employee

- (NSString*)fullName {
    return [[firstName stringByAppendingString:@" "] stringByAppendingString: lastName];
}

- (id)initWithFirstName:(NSString*)fName lastName:(NSString*)lName salary:(int)sal {
    firstName = fName;
    lastName = lName;
    salary = sal;
    return self;
}

@end
