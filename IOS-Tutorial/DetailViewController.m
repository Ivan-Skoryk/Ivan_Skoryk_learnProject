//
//  DetailViewController.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/24/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@'s salary is", [self.employee.fullName componentsSeparatedByString:@" "][1]];
    self.salaryLabel.text = [NSString stringWithFormat:@"%d", self.employee.salary];
}

@end
