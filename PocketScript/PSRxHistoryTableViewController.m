//
//  PSRxHistoryTableViewController.m
//  PocketScript
//
//  Created by Andrew Brandt on 10/8/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import "PSRxHistoryTableViewController.h"
#import "PSRxOrderDetailViewController.h"
#import "PSRxOrderTableViewCell.h"
#import "AppDelegate.h"
#import "RxOrder.h"

@interface PSRxHistoryTableViewController ()

@end

@implementation PSRxHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    UINib *nib = [UINib nibWithNibName:@"PSRxOrderTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"RxOrderCell"];
    
    self.orders = [self fetchAllOrders];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PSRxOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RxOrderCell" forIndexPath:indexPath];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PSRxOrderTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-YYYY, hh:mm aa"];
    NSString *prettyVersion = [dateFormat stringFromDate:[self.orders[indexPath.row] submitTimestamp]];
    
    cell.timestamp.text = prettyVersion;
    
    cell.status.text = @"Pending";
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PSRxOrderDetailViewController *destination = [segue destinationViewController];
    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    destination.order = self.orders[selectedIndexPath.row];
}


- (NSArray *)fetchAllOrders {
    NSArray *result = nil;
    NSError *error = nil;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"RxOrder" inManagedObjectContext:self.context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    result = [self.context executeFetchRequest:request error:&error];

    return result;
}

@end
