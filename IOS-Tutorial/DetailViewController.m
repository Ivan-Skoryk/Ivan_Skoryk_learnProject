//
//  DetailViewController.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/24/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize salaryLabel;
@synthesize employee;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@'s salary is", [employee.fullName componentsSeparatedByString:@" "][1]];
    salaryLabel.text = [NSString stringWithFormat:@"%d", employee->salary];
}

@end
