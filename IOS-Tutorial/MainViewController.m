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
    //[self createOrganizationAndAddingEmployees];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = delegate.persistentContainer.viewContext;
    [self loadOrganization];
    //NSLog(self.org.description);
    
    [self.myTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
}

#pragma mark - Creating data

- (void)loadOrganization {
    NSManagedObjectContext *threadContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [threadContext setParentContext:self.context];
    
    NSFetchRequest *request = [OrganizationMO fetchRequest];
    
    self.moOrg = [threadContext executeFetchRequest:request error:nil].firstObject;
    //NSLog(mo.description);
    
    self.org = [OrganizationMO moToOrganization:self.moOrg];
}

- (void)createOrganizationAndAddingEmployees {
    //NSLog(@"Init organization");
    self.org = [[Organization alloc] initWithName:@"Balalaika Ltd."];
    //NSLog(@"Organization: %@", self.org.name);

    //NSLog(@"Adding some employees to organization");
    for (int i = 0; i < 7; i++) {
        NSString *str = [NSString stringWithFormat:@"Name%d Surname%d", i, i];
        [self.org addEmployeeWithName:str];
        //NSLog(@"Employee added with name: %@", str);
    }
}

- (void)reloadEmployees {
    NSManagedObjectContext *threadContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [threadContext setParentContext:self.context];
    
    NSFetchRequest *request = [EmployeeMO fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"organization.name == %@", self.org.name]];
    NSArray<NSManagedObject *> *empArr = [threadContext executeFetchRequest:request error:nil];
    
    [self.org reloadEmployeesWithArray:empArr];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEmployeeDetail"]) {
        DetailViewController *destVC = segue.destinationViewController;
        destVC.employee = [self.org getEmployeeAtIndex:[self.myTableView indexPathForSelectedRow].row];
    }
    if ([segue.identifier isEqualToString:@"showCreateEmployeeVC"]) {
        CreateEmployeeViewController *destVC = segue.destinationViewController;
        destVC.delegate = self;
        //destVC.org = (OrganizationMO *)self.moOrg;
    }
}

#pragma mark - CreateEmployeeDelegate

- (void)didTapSaveButton:(EmployeeMO *)emp {
    //[self.org addEmployee:emp];
    
    [[self.context executeFetchRequest:[OrganizationMO fetchRequest] error:nil].firstObject addEmployeesObject:emp];
    
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self reloadEmployees];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        NSFetchRequest *request = [EmployeeMO fetchRequest];
        
        EmployeeMO *emp = [self.context executeFetchRequest:request error:nil][indexPath.row];
        
        [[self.context executeFetchRequest:[OrganizationMO fetchRequest] error:nil].firstObject removeEmployeesObject:emp];
        [self.context deleteObject:emp];
        NSError *error = nil;
        if (![self.context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self reloadEmployees];
    }
}

@end
