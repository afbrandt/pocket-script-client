//
//  PSRxHistoryTableViewController.m
//  PocketScript
//
//  Created by Andrew Brandt on 10/8/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import "PSRxHistoryTableViewController.h"
#import "AppDelegate.h"
#import "RxOrder.h"

@interface PSRxHistoryTableViewController ()

@end

@implementation PSRxHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
    self.orders = [self fetchAllOrders];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RxOrderCell" forIndexPath:indexPath];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-YYYY, hh:mm aa"];
    NSString *prettyVersion = [dateFormat stringFromDate:[self.orders[indexPath.row] submitTimestamp]];
    
    cell.textLabel.text = prettyVersion;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
