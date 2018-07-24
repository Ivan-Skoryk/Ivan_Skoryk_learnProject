//
//  ViewController.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - Variables

@synthesize myTableView;
@synthesize org;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createOrganizationAndAddingEmployees];
    //DetailViewController
    
}

#pragma mark - Creating data

-(void) createOrganizationAndAddingEmployees {
    NSLog(@"Init organization");
    org = [[Organization alloc] initWithName:@"Balalaika Ltd."];
    NSLog(@"Organization: %@", org->name);
    
    NSLog(@"Adding some employees to organization");
    for (int i = 0; i < 7; i++) {
        NSString *str = [NSString stringWithFormat:@"Name%d Surname%d", i, i];
        [org addEmployeeWithName:str];
        NSLog(@"Employee added with name: %@", str);
    }
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEmployeeDetail"]) {
        DetailViewController *destVC = segue.destinationViewController;
        destVC.employee = [org getEmployeeAtIndex:[myTableView indexPathForSelectedRow].row];
    }
    if ([segue.identifier isEqualToString:@"showCreateEmployeeVC"]) {
        CreateEmployeeViewController *destVC = segue.destinationViewController;
        destVC.delegate = self;
    }
}

#pragma mark - CreateEmployeeDelegate

- (void) didTapSaveButton:(Employee*) emp {
    [org addEmployee:emp];
    [myTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"employeeCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [org getEmployeeAtIndex:indexPath.row].fullName;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[org getEmployeeArray] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}


@end
