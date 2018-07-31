//
//  ViewController.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Organization.h"
#import "OrganizationMO.h"
#import "CreateEmployeeViewController.h"

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CreateEmployeeDelegate>

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (nonatomic, strong) OrganizationMO *moOrg;
@property (nonatomic, strong) Organization *org;

- (void)loadFirstOrganization;

- (void)loadOrganizationWithName:(NSString *)name;

- (void)reloadEmployees;

- (void)createOrganizationAndAddingEmployees;

@end

