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
@property (weak, nonatomic) IBOutlet UILabel *dObLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@'s", [self.employee.fullName componentsSeparatedByString:@" "][1]];
    self.salaryLabel.text = [NSString stringWithFormat:@"Salary is: %d", self.employee.salary];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.YYYY"];
    self.dObLabel.text = [NSString stringWithFormat:@"Date of Birth: %@", [df stringFromDate:self.employee.dateOfBirth]];
}

@end
