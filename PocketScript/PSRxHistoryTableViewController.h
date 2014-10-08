//
//  PSRxHistoryTableViewController.h
//  PocketScript
//
//  Created by Andrew Brandt on 10/8/14.
//  Copyright (c) 2014 Andrew Brandt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSRxHistoryTableViewController : UITableViewController

@property (nonatomic, copy) NSArray *orders;
@property (nonatomic, retain) NSManagedObjectContext *context;

@end
