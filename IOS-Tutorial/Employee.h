//
//  Model.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Employee : NSObject

@property (assign, nonatomic) int salary;

@property (nonatomic, readonly) NSString *fullName;

- (id)initWithFirstName:(NSString *)fName lastName:(NSString *)lName salary:(int)sal;

@end
