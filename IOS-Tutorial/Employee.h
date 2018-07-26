//
//  Model.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Employee : NSManagedObject

@property (assign, nonatomic) int salary;

@property (nonatomic, readonly) NSString *fullName;

- (id) initWithManagedObject:(NSManagedObject *)obj;

@end

#import "Employee+CoreDataProperties.h"
