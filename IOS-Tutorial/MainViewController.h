//
//  ViewController.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Organization.h"
#import "CreateEmployeeViewController.h"

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CreateEmployeeDelegate>

@property (nonatomic, strong) Organization *org;

- (void)createOrganizationAndAddingEmployees;

@end

