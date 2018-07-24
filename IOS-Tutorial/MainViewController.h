//
//  ViewController.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Organization.h"

@interface MainViewController : UIViewController

@property (nonatomic, strong) Organization *org;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

-(void) createOrganizationAndAddingEmployees;

@end

