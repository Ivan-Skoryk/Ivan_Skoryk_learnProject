//
//  EmployeeMO+CoreDataProperties.h
//  
//
//  Created by Ivan Skoryk on 7/27/18.
//
//

#import "EmployeeMO.h"


NS_ASSUME_NONNULL_BEGIN

@interface EmployeeMO (CoreDataProperties)

+ (NSFetchRequest<EmployeeMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nonatomic) int32_t salary;
@property (nullable, nonatomic, copy) NSDate *dateOfBirth;
@property (nullable, nonatomic, retain) OrganizationMO *organization;

@end

NS_ASSUME_NONNULL_END
