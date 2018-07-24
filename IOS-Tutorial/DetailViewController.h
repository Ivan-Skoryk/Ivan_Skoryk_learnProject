//
//  DetailViewController.h
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/24/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Employee *employee;
@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;

@end
