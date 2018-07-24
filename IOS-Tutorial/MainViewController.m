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

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MainViewController

#pragma mark - Variables

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createOrganizationAndAddingEmployees];
    //DetailViewController
    
}

#pragma mark - Creating data

- (void)createOrganizationAndAddingEmployees {
    NSLog(@"Init organization");
    self.org = [[Organization alloc] initWithName:@"Balalaika Ltd."];
    NSLog(@"Organization: %@", self.org.name);
    
    NSLog(@"Adding some employees to organization");
    for (int i = 0; i < 7; i++) {
        NSString *str = [NSString stringWithFormat:@"Name%d Surname%d", i, i];
        [self.org addEmployeeWithName:str];
        NSLog(@"Employee added with name: %@", str);
    }
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEmployeeDetail"]) {
        DetailViewController *destVC = segue.destinationViewController;
        destVC.employee = [self.org getEmployeeAtIndex:[self.myTableView indexPathForSelectedRow].row];
    }
    if ([segue.identifier isEqualToString:@"showCreateEmployeeVC"]) {
        CreateEmployeeViewController *destVC = segue.destinationViewController;
        destVC.delegate = self;
    }
}

#pragma mark - CreateEmployeeDelegate

- (void)didTapSaveButton:(Employee*)emp {
    [self.org addEmployee:emp];
    [self.myTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"employeeCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.org getEmployeeAtIndex:indexPath.row].fullName;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.org getEmployeeArray] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

@end
