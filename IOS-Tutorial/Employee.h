//
//  Model.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject {
    
@private
    NSString *firstName;
    NSString *lastName;
    
@public
    int salary;
}

@property(nonatomic, readonly)NSString *fullName;

- (id)initWithFirstName:(NSString*)fName lastName:(NSString*)lName salary:(int)sal;

@end
