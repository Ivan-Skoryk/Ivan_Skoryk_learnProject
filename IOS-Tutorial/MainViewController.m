//
//  ViewController.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "IOS_Tutorial-Swift.h"

@interface MainViewController ()

#pragma mark - Variables

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MainViewController

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = delegate.persistentContainer.viewContext;
    [self loadFirstOrganization];
    
    [self.myTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(employeesOrderDidChange) name:@"EmployeesOrderHasChanged" object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(catchOrgName:) name:@"OrganizationHasPicked" object:nil];
}

#pragma mark - Creating data

- (void)loadFirstOrganization {
    NSManagedObjectContext *threadContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [threadContext setParentContext:self.context];
    
    NSFetchRequest *request = [OrganizationMO fetchRequest];
    self.moOrg = [threadContext executeFetchRequest:request error:nil].firstObject;
    
    self.org = [OrganizationMO moToOrganization:self.moOrg];
}

- (void)loadOrganizationWithName:(NSString *)orgName {
    NSManagedObjectContext *threadContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [threadContext setParentContext:self.context];
    
    NSFetchRequest *request = [OrganizationMO fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@", orgName]];
    self.moOrg = [threadContext executeFetchRequest:request error:nil].firstObject;
    
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
    if ([segue.identifier isEqualToString:@"showEmployeeDetailVC"]) {
        DetailViewController *destVC = segue.destinationViewController;
        destVC.employee = [self.org getEmployeeAtIndex:[self.myTableView indexPathForSelectedRow].row];
    }
    if ([segue.identifier isEqualToString:@"showCreateEmployeeVC"]) {
        CreateEmployeeViewController *destVC = segue.destinationViewController;
        destVC.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"showOrgInfoVC"]) {
        OrganizationInfoViewController *orgVC = segue.destinationViewController;
        orgVC.org = self.org;
    }
}

#pragma mark - CreateEmployeeDelegate

- (void)didTapSaveButton:(EmployeeMO *)emp {
    NSFetchRequest *request = [OrganizationMO fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name == %@", self.org.name]];
    [[self.context executeFetchRequest:request error:nil].firstObject addEmployeesObject:emp];
    
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
        
        Employee *tmp = [self.org getEmployeeAtIndex:indexPath.row];
        NSFetchRequest *request = [EmployeeMO fetchRequest];
        [request setPredicate:[NSPredicate predicateWithFormat:@"firstName == %@ AND lastName == %@",[tmp.fullName componentsSeparatedByString:@" "][0], [tmp.fullName componentsSeparatedByString:@" "][1]]];
        EmployeeMO *emp = [self.context executeFetchRequest:request error:nil].firstObject;
        
        NSFetchRequest *orgRequest = [OrganizationMO fetchRequest];
        [orgRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", self.org.name]];
        [[self.context executeFetchRequest:orgRequest error:nil].firstObject  removeEmployeesObject:emp];
        [self.context deleteObject:emp];
        
        NSError *error = nil;
        if (![self.context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self reloadEmployees];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)catchOrgName:(NSNotification *)notification {
    [self loadOrganizationWithName:(NSString *)notification.userInfo[@"name"]];
    [self.myTableView reloadData];
}

- (void)employeesOrderDidChange {
    [self.myTableView reloadData];
}

@end
