//
//  ViewController.m
//  IOS-Tutorial
//
//  Created by Ivan Skoryk on 7/23/18.
//  Copyright © 2018 FaiFly. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MainViewController

#pragma mark - Variables

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.myTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = delegate.persistentContainer.viewContext;
    
    [self createOrganizationAndAddingEmployees];
    
    [self.myTableView reloadData];
    [self.myTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
}

#pragma mark - Creating data

- (void)createOrganizationAndAddingEmployees {
    NSLog(@"Init organization");
    NSFetchRequest *request = [Organization fetchRequest];
    [request setReturnsObjectsAsFaults:NO];
    NSManagedObject *orgObj = [self.context executeFetchRequest:request error:nil].firstObject;
    //NSLog(orgObj.description);
    self.org = [[Organization alloc] initWithManagedObject:orgObj];
    
    [self reloadEmployeesForOrganization:self.org];
    //NSLog(@"Organization: %@", self.org.name);
    
//    NSLog(@"Adding some employees to organization");
//    for (int i = 0; i < 7; i++) {
//        NSString *str = [NSString stringWithFormat:@"Name%d Surname%d", i, i];
//        [self.org addEmployeeWithName:str];
//        NSLog(@"Employee added with name: %@", str);
//    }
    
//    request = [Employee fetchRequest];
//    [request setReturnsObjectsAsFaults:NO];
//    [request setPredicate: [NSPredicate predicateWithFormat:@"idOrganization == %d",
//                            [[orgObj valueForKey:@"idOrganization"] intValue]]];
//    NSArray *tmpEmp = [self.context executeFetchRequest:request error:nil];
//    //NSLog(tmpEmp.description);
//
//    Employee *emp;
//    for(int i = 0; i < [tmpEmp count]; i++) {
//        emp = [[[Employee alloc] init] initWithManagedObject:tmpEmp[i]];
//        [self.org addEmployee:emp];
//        ;
//
//    }
    
}

- (void)reloadEmployeesForOrganization:(Organization *)org {
    
    NSFetchRequest *orgRequest = [Organization fetchRequest];
    [orgRequest setPredicate: [NSPredicate predicateWithFormat:@"name == %@", org.name]];
    
    NSManagedObject *orgObj = [self.context executeFetchRequest:orgRequest error:nil].firstObject;
    
    NSFetchRequest *empRequest = [Employee fetchRequest];
    [empRequest setPredicate: [NSPredicate predicateWithFormat:@"idOrganization == %d",
                               [[orgObj valueForKey:@"idOrganization"] intValue]]];
    NSArray *tmpEmp = [self.context executeFetchRequest:empRequest error:nil];
    
    [org loadEmployeesFromArray:tmpEmp];
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
    }
}

#pragma mark - CreateEmployeeDelegate

- (void)didTapSaveButton/*:(Employee *)emp*/ {
    [self reloadEmployeesForOrganization:self.org];
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSFetchRequest *request = [Employee fetchRequest];
        [request setPredicate:[NSPredicate predicateWithFormat:@"firstName == %@ AND lastName == %@", [[self.org getEmployeeAtIndex:indexPath.row].fullName componentsSeparatedByString:@" "][0], [[self.org getEmployeeAtIndex:indexPath.row].fullName componentsSeparatedByString:@" "][1]]];
        
        NSManagedObject *emp = [self.context executeFetchRequest:request error:nil].firstObject;
        [self.context deleteObject:emp];
        
        NSError *error = nil;
        if (![self.context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self.org removeEmployee:[self.org getEmployeeAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
